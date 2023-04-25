import 'package:flutter/material.dart';
import 'package:snackchat/Screens/loginScreen.dart';

import 'LoginPage.dart';
import 'userlogin.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            SizedBox(
              height: 90,
            ),
            Text(
              "Welcome To SnackChat",
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.w600,
                color: Colors.orange[800],
              ),
            ),
            SizedBox(
              height: 60
            ),
            Image.asset(
              "assets/images/loglogo.png",
              color: Colors.orange[800],
              height: 300,
              width: 400,
            ),
            SizedBox(
              height: 70,
            ),
            Text(
              "Let's get started",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Never a better time than now to start !!",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black38,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    backgroundColor: MaterialStateProperty.all(Colors.orange),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)))),
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 300,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()));
                },
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.orange),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24))),
                ),
                child: Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
