import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snackchat/Model/CountryModel.dart';
import 'package:snackchat/NewScreen/CountryPage.dart';
import 'package:snackchat/NewScreen/pagelogin.dart';
import 'package:snackchat/Screens/loginScreen.dart';
import 'package:snackchat/components/button.dart';

import 'package:snackchat/widgets/login_mobile.dart';
import 'package:snackchat/widgets/otpPage.dart';
import '../providers/createAccount.dart';
import '../providers/http_exception.dart';

import 'userlogin.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 30;
  late Timer _timer;

  final formKey = GlobalKey<FormState>();
  String name = "";
  String countryname = "India";
  String countrycode = "+91";
  final _form = GlobalKey<FormState>();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var numberController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  get height => 90;

  get hintText => null;
  bool _isLoading = false;

  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _numberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
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

  void _saveForm() {
    print('save form');
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
  }

  //final RegExp _phoneNumberRegExp = RegExp(r'^\+[1-9]{1}[0-9]{3,14}$');
  final RegExp _phoneNumberRegExp = RegExp(r'^(\+|\d)[0-9]{7,16}$');
  final RegExp _emailRegExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");

  Future<void> _submit(context) async {
    var userFirstName = firstNameController.text;
    var userLastName = lastNameController.text;
    var email = emailController.text;
    var mobile = numberController.text;
    var password = passwordController.text;
    var _userGuid = 'something';

    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      var registrationResponse =
          await Provider.of<CreateAccount>(context, listen: false)
              .createUserAccount(
                  userFirstName, userLastName, email, mobile, password);
      //var userObj = json.decode(registrationResponse);
      if (registrationResponse['user_guid'] != '' &&
          registrationResponse['user_guid'] != null) {
        _userGuid = registrationResponse['user_guid'];
        Navigator.of(context).pushNamed(OtpPage.routeName, arguments: {
          "guid": _userGuid,
          "v_message": registrationResponse['verification_message']
        });
      } else {
        _showErrorDialog(registrationResponse['message']);
      }
      firstNameController.clear();
      lastNameController.clear();
      numberController.clear();
      emailController.clear();
      passwordController.clear();
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
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade200,
        title: const Text(
          "SNACK CHAT",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 25,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 8.0,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 40),
            height: deviceSize.height - 100,
            child: Form(
              key: _form,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Create Account',
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Anton',
                        color: Colors.orange,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  /* textfield(
                 controller: usernameController,
                 hintText: 'Name',
                 obscureText: false,
               ),
              */
                  TextFormField(
                    controller: firstNameController,
                    decoration: InputDecoration(
                      labelText: "First name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 104, 102, 102)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 5, 5, 5),
                        ),
                      ),
                      fillColor: Colors.white60,
                      filled: true,
                      hintText: hintText,
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 14, 3, 3)),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    focusNode: _firstNameFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_numberFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please provide a value.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: lastNameController,
                    decoration: InputDecoration(
                      labelText: "Last name",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 104, 102, 102)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 5, 5, 5),
                        ),
                      ),
                      fillColor: Colors.white60,
                      filled: true,
                      hintText: hintText,
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 14, 3, 3)),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    focusNode: _lastNameFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_numberFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please provide a value.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  /*textfield(
                  controller: usernameController,
                  hintText: 'Phone Number',
                  obscureText: false,
        
                ),*/
                  TextFormField(
                    controller: numberController,
                    decoration: InputDecoration(
                      labelText: "Mobile Number",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 104, 102, 102)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 5, 5, 5),
                        ),
                      ),
                      fillColor: Colors.white60,
                      filled: true,
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    focusNode: _numberFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_emailFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a phone number';
                      } else if (!_phoneNumberRegExp.hasMatch(value!)) {
                        return 'Please enter a valid 10-digit phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  /* textfield(
                  controller: usernameController,
                  hintText: 'Email ID',
                  obscureText: false,
                ),
                */
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 104, 102, 102)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 5, 5, 5),
                        ),
                      ),
                      fillColor: Colors.white60,
                      filled: true,
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _emailFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please provide a value";
                      } else if (!_emailRegExp.hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  /*textfield(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),*/

                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 3, color: Color.fromARGB(255, 20, 19, 19)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2,
                          color: Color.fromARGB(255, 5, 5, 5),
                        ),
                      ),
                      fillColor: Colors.white60,
                      filled: true,
                      hintText: hintText,
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.multiline,
                    focusNode: _passwordFocusNode,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please provide a valid password.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () async {
                      _startTimer();
                      _submit(context);
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      alignment: Alignment.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Already Having Account?",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 5),
                      InkWell(
                        child: Text(
                          "LOG IN",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _startTimer {}
