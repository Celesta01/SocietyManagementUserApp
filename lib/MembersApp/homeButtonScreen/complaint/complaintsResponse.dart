// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:societyuser_app/membersApp/common_widget/colors.dart';

// ignore: must_be_immutable
class ViewComplaints extends StatefulWidget {
  ViewComplaints({
    super.key,
    this.response,
    required this.complaintsType,
    required this.text,
  });
  String? response;
  String complaintsType;
  String text;
  @override
  State<ViewComplaints> createState() => _ViewComplaintsState();
}

class _ViewComplaintsState extends State<ViewComplaints> {
  List<dynamic> dataList = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    // getTypeOfNoc(widget.society, widget.flatNo, widget.nocType,widget.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.98,
            height: MediaQuery.of(context).size.height * 0.98,
            child: Card(
              elevation: 5,
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.85,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              widget.complaintsType,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: textColor),
                            ),
                            Text(
                              widget.text,
                              style: TextStyle(fontSize: 12, color: textColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Text(
                                  "Response: ${widget.response ?? 'No Response Given'}",
                                  style: TextStyle(
                                      color: textColor, fontSize: 15))),
                        ]),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  alertbox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'OK',
                    style: TextStyle(color: textColor),
                  )),
            ],
            title: const Text(
              'Please select a file first!',
              style: TextStyle(color: Colors.red),
            ));
      },
    );
  }
}
