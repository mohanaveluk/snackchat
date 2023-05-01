import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async' show Timer;
import '../Screens/chat_home_screen.dart';
import '../providers/createAccount.dart';
import '../providers/http_exception.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});
  static const routeName = '/otp_page';

  @override
  State<OtpPage> createState() => _otpPageState();
}

class _otpPageState extends State<OtpPage> {
  bool _isResendButtonDisabled = false;
  int _counter = 30;
  late Timer _timer;
  var _userGuid = '';
  var _verification_message = '';
  bool _isLoading = false;

  final TextEditingController _codeController = TextEditingController();
  final _codeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _timer = Timer(Duration(seconds: 0), () => {});
  }

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An error occured'),
              content: Text(message.replaceAll("HttpException:", "Oops,")),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            ));
  }

  void _startTimer() {
    _counter = 30;
    if (_timer != null) {
      _timer.cancel();
    }
    setState(() {
      _isResendButtonDisabled = true;
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _isResendButtonDisabled = false;
          _timer.cancel();
        }
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    var userModel = ModalRoute.of(context)?.settings.arguments as Map;
    _verification_message = userModel['v_message'];
    _userGuid = userModel['guid'];

    _startTimer();

    super.didChangeDependencies();
  }

  Future<void> _submit(context) async {
    var _code = _codeController.text;

    setState(() {
      _isLoading = true;
    });

    try {
      var token = await Provider.of<CreateAccount>(context, listen: false)
          .submitVerifictionCode(_userGuid, _code);

      if (token != '') {
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatHome.fromBase64(token)));
      }
    } on HttpException catch (e) {
      _showErrorDialog(e.message);
    } catch (e) {
      _showErrorDialog(e.toString());
    }

    setState(() {
      _isLoading = false;
    });
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
        elevation: 8,
        title: const Text(
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
            Text(
              _verification_message,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              controller: _codeController,
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
              focusNode: _codeFocusNode,
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
            if (_isLoading)
              Container(
                padding: EdgeInsets.only(right: 130, left: 130),
                child: const CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              )
            else
              Container(
                padding: const EdgeInsets.fromLTRB(12, 5, 12, 5),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.orange,
                      fixedSize: Size.fromHeight(50),
                      textStyle: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      foregroundColor: Colors.white),
                  onPressed: () async {
                    _submit(context);
                  },
                  child: const Text('Verify Code'),
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
