import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:societyuser_app/MembersApp/auth/splash_service.dart';
import 'package:societyuser_app/MembersApp/common_widget/colors.dart';
import 'package:societyuser_app/MembersApp/homeButtonScreen/ledger/debitNoteDetails.dart';
import 'package:societyuser_app/MembersApp/homeButtonScreen/ledger/ledgerBillDetails.dart';
import 'package:societyuser_app/MembersApp/homeButtonScreen/ledger/ledgerReceiptDetails.dart';

// ignore: camel_case_types, must_be_immutable
class memberLedger extends StatefulWidget {
  memberLedger(
      {super.key,
      required this.flatno,
      required this.societyName,
      required this.username});

  String flatno;
  String societyName;
  String username;

  @override
  State<memberLedger> createState() => _memberLedgerState();
}

// ignore: camel_case_types
class _memberLedgerState extends State<memberLedger> {
  List<int> listOfIndex = [];
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController electricController = TextEditingController();
  final TextEditingController billnoController = TextEditingController();
  final SplashService _splashService = SplashService();
  String monthyear = DateFormat('MMMM yyyy').format(DateTime.now());

  String electric = '';
  String totalAmount = '';
  String billno = '';
  String water = '';
  bool isLoading = true;

  // ignore: non_constant_identifier_names

  String currentmonth = DateFormat('MMMM yyyy').format(DateTime.now());

  //List of Data with Bill Number
  List<dynamic> allDataWithBill = [];
  List<dynamic> allDataWithReceipt = [];
  List<dynamic> monthList = [];
  List<List<dynamic>> rowList = [];
  List<String> particulartsLableList = [];
  List<dynamic> colums = [
    'Date',
    'Particulars',
    'Bills\nDebits',
    'Credits\nReceipts',
    'Balance',
  ];
  String flatno = '';
  String date = '';
  String date2 = '';
  String particulars = '';
  String amount = '';
  String month = '';
  List<List<dynamic>> billNoList = [];
  List<List<dynamic>> creditList = [];
  List<List<dynamic>> debitList = [];
  List<List<dynamic>> receiptList = [];
  List<dynamic> billMapData = [];
  List<dynamic> receiptMapData = [];
  Map<String, dynamic> debitMapData = {};
  Map<String, dynamic> creditMapData = {};

  String phoneNum = '';
  @override
  initState() {
    super.initState();
    // LedgerList('siddivinayak');
    getBill(widget.societyName, widget.flatno).whenComplete(() async {
      await getReceipt(widget.societyName, widget.flatno);
      await debitNoteData();
      await creditNoteData();
      mergeAllList();
      isLoading = false;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarBgColor,
        title: const Text(
          'Member Ledger',
          style: TextStyle(color: Colors.white),
        ),
      ),
      // drawer: const MyDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    padding: const EdgeInsets.all(2.0),
                    child: Card(
                      elevation: 5,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DataTable(
                        // dataRowMinHeight: 10,
                        columnSpacing: 5,
                        columns: List.generate(5, (index) {
                          return DataColumn(
                            label: Text(
                              colums[index],
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }),
                        rows: List.generate(
                          rowList.length,
                          (index1) {
                            return DataRow(
                              cells: List.generate(
                                rowList[0].length,
                                (index2) {
                                  // print(rows[index2]);
                                  return DataCell(
                                    index2 == 1
                                        ? particulartsLableList[index1] ==
                                                'Bill No.'
                                            ? TextButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return LedgerBillDetailsPage(
                                                          flatno: widget.flatno,
                                                          name: widget.username,
                                                          societyName: widget
                                                              .societyName,
                                                          BillData: billMapData[
                                                              index1],
                                                        );
                                                      },
                                                    ),
                                                  );
                                                },
                                                child: Text(
                                                  '${particulartsLableList[index1]}\n ${rowList[index1][index2]}',
                                                  style: const TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : particulartsLableList[index1] ==
                                                    'Receipt No.'
                                                ? TextButton(
                                                    onPressed: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return LedgerReceiptDetailsPage(
                                                            flatno:
                                                                widget.flatno,
                                                            name:
                                                                widget.username,
                                                            societyName: widget
                                                                .societyName,
                                                            receiptData:
                                                                receiptMapData[
                                                                    index1]);
                                                      }));
                                                    },
                                                    child: Text(
                                                      '${particulartsLableList[index1]}\n ${rowList[index1][index2]}',
                                                      style: const TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  )
                                                : particulartsLableList[
                                                            index1] ==
                                                        'Debit Note'
                                                    ? TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return DebitNoteDetails(
                                                                flatno: widget
                                                                    .flatno,
                                                                name: widget
                                                                    .username,
                                                                societyName: widget
                                                                    .societyName,
                                                                noteData:
                                                                    debitMapData[
                                                                        index1]);
                                                          }));
                                                        },
                                                        child: Text(
                                                          '${particulartsLableList[index1]}\n ${rowList[index1][index2]}',
                                                          style: const TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                                    : TextButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return LedgerReceiptDetailsPage(
                                                                flatno: widget
                                                                    .flatno,
                                                                name: widget
                                                                    .username,
                                                                societyName: widget
                                                                    .societyName,
                                                                receiptData:
                                                                    creditMapData[
                                                                        index1]);
                                                          }));
                                                        },
                                                        child: Text(
                                                          '${particulartsLableList[index1]}\n ${rowList[index1][index2]}',
                                                          style: const TextStyle(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      )
                                        : Text(
                                            rowList[index1][index2] ?? '0',
                                            style: const TextStyle(
                                              fontSize: 10,
                                            ),
                                          ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mergeAllList();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> getBill(String societyname, String flatno) async {
    billNoList.clear();
    isLoading = true;

    phoneNum = await _splashService.getPhoneNum();

    QuerySnapshot societyQuerySnapshot = await FirebaseFirestore.instance
        .collection('ladgerBill')
        .doc(societyname)
        .collection('month')
        .get();
    List<dynamic> monthList =
        societyQuerySnapshot.docs.map((e) => e.id).toList();

    for (var i = 0; i < monthList.length; i++) {
      DocumentSnapshot data = await FirebaseFirestore.instance
          .collection('ladgerBill')
          .doc(societyname)
          .collection('month')
          .doc(monthList[i])
          .get();
      if (data.exists) {
        Map<String, dynamic> totalusers = data.data() as Map<String, dynamic>;
        List<dynamic> mapData = totalusers['data'];
        billMapData = mapData;
        billMapData.removeAt(0);

        for (var data in mapData) {
          List<dynamic> row = [];

          if (flatno == data['Flat No.']) {
            allDataWithBill.add(data);
            row.add(data['Bill Date']);
            row.add(data['Bill No']);
            row.add(data['Bill Amount']);
            row.add(data['0']);
            row.add(data['Bill Amount']);
            billNoList.add(row);
            break;
          }
        }
      }
    }
  }

  Future<void> getReceipt(String societyname, String flatno) async {
    receiptList.clear();
    isLoading = true;
    phoneNum = await _splashService.getPhoneNum();
    QuerySnapshot societyQuerySnapshot = await FirebaseFirestore.instance
        .collection('ladgerReceipt')
        .doc(societyname)
        .collection('month')
        .get();
    List<dynamic> monthList =
        societyQuerySnapshot.docs.map((e) => e.id).toList();

    for (var i = 0; i < monthList.length; i++) {
      DocumentSnapshot data = await FirebaseFirestore.instance
          .collection('ladgerReceipt')
          .doc(societyname)
          .collection('month')
          .doc(monthList[i])
          .get();
      if (data.exists) {
        Map<String, dynamic> totalusers = data.data() as Map<String, dynamic>;
        List<dynamic> mapData = totalusers['data'];
        receiptMapData = mapData;

        for (var data in mapData) {
          List<dynamic> receipt = [];

          if (flatno == data['Flat No.']) {
            allDataWithReceipt.add(data);
            receipt.add(data['Receipt Date']);
            receipt.add(data['Flat No.']);
            receipt.add(data['0']);
            receipt.add(data['Amount']);
            receipt.add(data['Amount']);
            receiptList.add(receipt);
            break;
          }
        }
      }
    }
    if (billNoList.length > receiptList.length) {
      int loopLen = billNoList.length - receiptList.length;
      for (var i = 0; i < loopLen; i++) {
        receiptList.add(['N/A', 'N/A', 'N/A', 'N/A', 'N/A']);
      }
    }
    // print(allRecepts.length);
  }

  Future<void> creditNoteData() async {
    creditList.clear();
    QuerySnapshot societyQuerySnapshot = await FirebaseFirestore.instance
        .collection('creditNote')
        .doc(widget.societyName)
        .collection('month')
        .get();
    monthList = societyQuerySnapshot.docs.map((e) => e.id).toList();

    for (var i = 0; i < monthList.length; i++) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('creditNote')
          .doc(widget.societyName)
          .collection('month')
          .doc(monthList[i])
          .collection('memberName')
          .doc(widget.username)
          .collection('noteNumber')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<dynamic> singleRow = [];
        Map<String, dynamic> data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        creditMapData = data;

        flatno = data['Flat No.'];
        amount = data['amount'];
        date = data['date'];
        particulars = data['particular'];
        monthyear = data['month'];
        date2 = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
        singleRow.add(date2);
        singleRow.add(particulars);
        singleRow.add('0');
        singleRow.add(amount);
        singleRow.add(amount);
        creditList.add(singleRow);
      }
    }
    if (debitList.length > creditList.length) {
      int loopLen = debitList.length - creditList.length;
      for (var i = 0; i < loopLen; i++) {
        creditList.add(['N/A', 'N/A', 'N/A', 'N/A', 'N/A']);
      }
    }
    // print('creditList - ${creditList}');
  }

  Future<void> debitNoteData() async {
    debitList.clear();
    QuerySnapshot societyQuerySnapshot = await FirebaseFirestore.instance
        .collection('debitNote')
        .doc(widget.societyName)
        .collection('month')
        .get();
    monthList = societyQuerySnapshot.docs.map((e) => e.id).toList();

    for (var i = 0; i < monthList.length; i++) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('debitNote')
          .doc(widget.societyName)
          .collection('month')
          .doc(monthList[i])
          .collection('memberName')
          .doc(widget.username)
          .collection('noteNumber')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        List<dynamic> singleRow = [];
        Map<String, dynamic> data =
            querySnapshot.docs.first.data() as Map<String, dynamic>;
        debitMapData = data;
        flatno = data['Flat No.'];
        amount = data['amount'];
        date = data['date'];
        particulars = data['particular'];
        monthyear = data['month'];
        date2 = DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
        singleRow.add(date2);
        singleRow.add(particulars);
        singleRow.add(amount);
        singleRow.add('0');
        singleRow.add(amount);
        debitList.add(singleRow);
      }
    }
    // print('debitList - $debitList');
  }

  void mergeAllList() {
    List<List<dynamic>> listOfRows = [];
    for (int i = 0; i < billNoList.length; i++) {
      listOfRows.add(billNoList[i]);
      particulartsLableList.add('Bill No.');
      listOfRows.add(receiptList[i]);
      particulartsLableList.add('Receipt No.');
      if (creditList.length >= i + 1) {
        listOfRows.add(debitList[i]);
        particulartsLableList.add('Debit Note');
        listOfRows.add(creditList[i]);
        particulartsLableList.add('Credit Note');
      }
    }
    print('rowList - ${listOfRows}');
    rowList = listOfRows;
  }
}
