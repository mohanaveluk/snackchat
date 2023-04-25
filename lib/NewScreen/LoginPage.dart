import 'package:flutter/material.dart';
import 'package:snackchat/Model/CountryModel.dart';
import 'package:snackchat/NewScreen/CountryPage.dart';
import 'package:snackchat/NewScreen/pagelogin.dart';
import 'package:snackchat/Screens/loginScreen.dart';
import 'package:snackchat/components/button.dart';
import 'package:snackchat/widgets/login_mobile.dart';

import 'userlogin.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String name = "";
  String countryname = "India";
  String countrycode = "+91";
  final _form = GlobalKey<FormState>();
  var usernameController;

  get height => 90;

  get hintText => null;

  final _nameFocusNode = FocusNode();
  final _numberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void _saveForm() {
    print('save form');
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    var passwordController;
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
                    height: 30,
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
                    height: 30,
                  ),
                  /* textfield(
                 controller: usernameController,
                 hintText: 'Name',
                 obscureText: false,
               ),
              */
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Name",
                      enabledBorder: OutlineInputBorder( borderSide: BorderSide( width: 3,
                              color: Color.fromARGB(255, 104, 102, 102)), ),
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 3,
                        color: Color.fromARGB(255, 5, 5, 5),
                       ),),
                      fillColor: Colors.white60,
                      filled: true,
                      hintText: hintText,
                      hintStyle:
                          TextStyle(color: Color.fromARGB(255, 14, 3, 3)),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.name,
                    focusNode: _nameFocusNode,
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
                    height: 20,
                  ),
                  /*textfield(
                  controller: usernameController,
                  hintText: 'Phone Number',
                  obscureText: false,
        
                ),*/
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Mobile Number",
                      enabledBorder: OutlineInputBorder(
                       borderSide: BorderSide( width: 3,
                              color: Color.fromARGB(255, 104, 102, 102)),
                       ),
                      focusedBorder: OutlineInputBorder(
                       borderSide: BorderSide(
                        width: 3,
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
                        return "Please provide a value.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  /* textfield(
                  controller: usernameController,
                  hintText: 'Email ID',
                  obscureText: false,
                ),
                */
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                       enabledBorder: OutlineInputBorder(
                       borderSide: BorderSide(
                         width: 3,
                              color: Color.fromARGB(255, 104, 102, 102)),
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(
                          width: 3,
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
                        return "Please provide a value.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
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
                        enabledBorder: OutlineInputBorder(
                         borderSide: BorderSide(
                           width: 3,
                              color: Color.fromARGB(255, 104, 102, 102)),
                       ),
                       focusedBorder: OutlineInputBorder(
                         borderSide: BorderSide(
                          width: 3,
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
                 Container(
                        padding: const EdgeInsets.only(left: 12, top: 5, right: 12, bottom: 5),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.orange,
                              fixedSize:  Size.fromHeight(50),
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                              foregroundColor: Colors.white),
                          onPressed: ()  {
                            
                          },
                          child: const Text('SIGN UP'),
                        ), 
                      ),
                  SizedBox(
                    height: 40,
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
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget CountryCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (builder) =>
                    CountryPage(setCountryData: setCountryData)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
            color: Colors.orange,
            width: 1.8,
          )),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Center(
                  child: Text(
                    countryname,
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.orange,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }

  Widget number() {
    return Container(
      width: MediaQuery.of(context).size.width / 1.5,
      height: 38,
      child: Row(
        children: [
          Container(
            width: 70,
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Colors.orange,
                width: 1.8,
              )),
            ),
            child: Row(
              children: [
                Text(
                  "+",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  countrycode.substring(1),
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void setCountryData(CountryModel countryModel) {
    setState(() {
      countryname = countryModel.name;
      countrycode = countryModel.code;
    });
    Navigator.pop(context);
  }
}
