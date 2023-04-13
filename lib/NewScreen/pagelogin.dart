import 'package:flutter/material.dart';
import 'package:snackchat/Screens/chat_home_screen.dart';
import 'package:snackchat/Screens/chat_overview_screen.dart';
import '../providers/http_exception.dart';
import '../providers/userAuthentication.dart';
import 'package:snackchat/NewScreen/LoginPage.dart';
import 'package:snackchat/components/logbutton.dart';
import 'package:provider/provider.dart';
import '../components/textfield.dart';
import 'dart:math';

enum AuthMode { Signup, Login }

class pagelogin extends StatefulWidget {
  pagelogin({Key? key}) : super(key: key);

  final _form = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void _saveForm() {
    print('save form');
    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
  }

  @override
  State<pagelogin> createState() => _pageloginState();
}

class _pageloginState extends State<pagelogin> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  String name = "";

  var usernameController;

  get height => 90;

  get _userNAmeFocusNode => null;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      key: _scaffoldKey,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: deviceSize.height,
              width: deviceSize.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 30.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade600,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Text(
                        'Snackchat',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'Anton',
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1,
                      child: const AuthCard()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _form {}

class AuthCard extends StatefulWidget {
  const AuthCard({super.key});

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  AuthMode _authMode = AuthMode.Login;
  Map<String, String> _authData = {'email': '', 'password': ''};
  bool _isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  String name = "";
  final _userNameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An error occured'),
              content: Text(message),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Ok'))
              ],
            ));
  }

  Future<void> _submit(context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      if (_authMode == AuthMode.Login) {
        //Login User
        var token =
            await Provider.of<UserAuthentication>(context, listen: false)
                .userSignIn2(_authData['email'], _authData['password']);
      } else if (_authMode == AuthMode.Login) {
        //Signup user
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

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthMode.Signup ? 400 : 400,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthMode.Signup ? 400 : 400,
        ),
        width: deviceSize.width * .75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              /*Text(
                "Here,",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[900],
                ),
              ),
              Text(
                "To Be",
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[900],
                ),
              ),
              Text(
                "Welcomed !!",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey[900],
                ),
              ),
              SizedBox(
                height: 50,
              ),*/
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: "Username",
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.orange.shade700),
                  // ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //     color: Colors.white,
                  //   ),
                  // ),
                  fillColor: Colors.white60,
                  filled: true,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                focusNode: _userNameFocusNode,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return "Invalid email";
                  }

                  return null;
                },
                onSaved: (value) {
                  _authData['email'] = value!;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.orange.shade700),
                  // ),
                  // focusedBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(
                  //     color: Colors.white,
                  //   ),
                  // ),
                  fillColor: Colors.white60,
                  filled: true,
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please provide a value.";
                  }
                  if (value.length < 5) {
                    return "Password is too short";
                  }

                  return null;
                },
                onSaved: (value) {
                  _authData['password'] = value!;
                },
              ),
              const SizedBox(
                height: 40,
              ),
              if (_isLoading)
                const CircularProgressIndicator(
                    backgroundColor: Colors.black,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red))
              else

                //logbutton(),
                ElevatedButton(
                    // onPressed: () {
                    //   await Provider.of<UserAuthentication>(context,
                    //           listen: false)
                    //       .userSignIn2(
                    //           'mohanaveluk@gmail.com', 'welcome@123', context);
                    // },
                    onPressed: () async {
                      var username = _usernameController.text;
                      var password = _passwordController.text;
                      var token = await Provider.of<UserAuthentication>(context,
                              listen: false)
                          .userSignIn2(username, password);
                      if (token != '') {
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChatHome.fromBase64(token)));
                      }
                    },
                    child: const Text("Submit")),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "New User !!",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                    child: const Text(
                      "Create an Account.",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
