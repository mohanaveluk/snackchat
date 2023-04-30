import 'package:flutter/material.dart';
import 'dart:async' show Timer;

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});
  static const routeName = '/otp_page';

  @override
  State<OtpPage> createState() => _otpPageState();
}

class _otpPageState extends State<OtpPage> {
  int _counter = 30;
  late Timer _timer;
  var _userGuid = '';

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 0), () => {});
  }

  void _startTimer() {
    _counter = 30;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _userGuid = ModalRoute.of(context)?.settings.arguments as String;
    print(_userGuid);

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_timer == null) {
      _timer = Timer(Duration(seconds: 0), () => {});
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 3,
        title: Text(
          "SIGN UP",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Verification code has been sent to your',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "mobile: ******5399",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(20),
                labelText: "Verification code",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 14, 10, 6), width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Color.fromARGB(255, 14, 13, 13),
                  ),
                ),
                fillColor: Colors.white60,
                filled: true,
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please provide a value.";
                }
                return null;
              },
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Verify OTP",
                ),
              ),
            ),
            SizedBox(height: 40),
            Row(
              children: [
                Text(
                  "Didn't recieve the verification code?",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                InkWell(
                  child: TextButton(
                    onPressed: () {
                      _startTimer();
                    },
                    child: Text(
                      'Resend OTP',
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  'Request another verification code in $_counter secs',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
