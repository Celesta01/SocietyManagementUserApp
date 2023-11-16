import 'package:flutter/material.dart';
import 'package:societyuser_app/HomeScreen/home_screen.dart';
import 'package:societyuser_app/auth/signup_page.dart';
import 'package:societyuser_app/common_widget/drawer.dart';

class loginScreen extends StatelessWidget {
  const loginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/theme.jpeg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Society",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            const Text(
              "Manager",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 70,
            ),
            const Text('Welcome Back',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    labelText: 'username',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    // enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  // controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    labelText: 'Password',
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    // enabledBorder: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                    )),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.87,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color.fromARGB(255, 0, 0, 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    minimumSize: const Size(180, 50),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
                    }));
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 28),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                SizedBox(
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const signUp();
                        }));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
            const SizedBox(
              child: Text(
                "Don't have an account? Sign Up",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
