import 'package:flutter/material.dart';
import 'package:snackchat/Model/CountryModel.dart';
import 'package:snackchat/NewScreen/CountryPage.dart';
import 'package:snackchat/NewScreen/pagelogin.dart';
import 'package:snackchat/components/button.dart';

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
          "Snackchat",
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Create Account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: 'Anton',
                        color: Colors.orange,
                        fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 10,
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
                      // enabledBorder: OutlineInputBorder( borderSide: BorderSide(color: Colors.orange.shade700), ),
                      //focusedBorder: OutlineInputBorder(
                      // borderSide: BorderSide(
                      //  color: Colors.white,
                      // ),),
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
                      //enabledBorder: OutlineInputBorder(
                      // borderSide: BorderSide(color: Colors.orange.shade700),
                      // ),
                      //focusedBorder: OutlineInputBorder(
                      // borderSide: BorderSide(
                      //  color: Colors.white,
                      //  ),
                      //  ),
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
                      //  enabledBorder: OutlineInputBorder(
                      //  borderSide: BorderSide(color: Colors.orange.shade700),
                      // ),
                      //  focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //    color: Colors.white,
                      //  ),
                      // ),
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
                      //  enabledBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(color: Colors.orange.shade700),
                      // ),
                      // focusedBorder: OutlineInputBorder(
                      //   borderSide: BorderSide(
                      //     color: Colors.white,
                      //  ),
                      // ),
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
                    height: 35,
                  ),
                  ElevatedButton(
                      // onPressed: () {
                      //   await Provider.of<UserAuthentication>(context,
                      //           listen: false)
                      //       .userSignIn2(
                      //           'mohanaveluk@gmail.com', 'welcome@123', context);
                      // },
                      onPressed: _saveForm,
                      child: const Text("Sign In")),
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
                                  builder: (context) => const UserLogin()));
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
