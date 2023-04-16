import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snackchat/NewScreen/userlogin.dart';
import '../providers/http_exception.dart';
import '../Screens/chat_home_screen.dart';
import '../providers/userAuthentication.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({super.key});

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  get height => 90;
  final AuthenticationMode _authMode = AuthenticationMode.Login;
  final _form = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey();

  get hintText => null;
  final _nameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Map<String, String> _authData = {'email': '', 'password': ''};
  bool _isLoading = false;

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
    print(_usernameController.text);
  }

  Future<void> _submit(context) async {
    var username = _usernameController.text;
    var password = _passwordController.text;

    final isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }

    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });

    try {
      // ignore: unrelated_type_equality_checks
      if (_authMode == AuthenticationMode.Login) {
        //Login User
        var token =
            await Provider.of<UserAuthentication>(context, listen: false)
                .userSignIn2(username, password);
        if (token != '') {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatHome.fromBase64(token)));
        }
      } else if (_authMode == AuthenticationMode.Login) {
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

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30), 
          child: Center(
            child: SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome back',
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Anton',
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to your account',
                    style: TextStyle(
                      fontSize: 23,
                      fontFamily: 'Anton',
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      hintStyle:
                          const TextStyle(color: Color.fromARGB(255, 14, 3, 3)),

                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 104, 102, 102)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      // Set border for focused state
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 32, 32, 32)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _nameFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                    validator: (value) {
                      if (value!.isEmpty ||
                          (!value.contains('@') && !value.contains('.'))) {
                        return "Invalid email";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _authData['email'] = value!;
                    },
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintStyle:
                          const TextStyle(color: Color.fromARGB(255, 14, 3, 3)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 104, 102, 102)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      // Set border for focused state
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3,
                            color: Color.fromARGB(255, 24, 24, 24)),
                        borderRadius: BorderRadius.circular(7),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _passwordFocusNode,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
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
                  const SizedBox(height: 25),
                  if (_isLoading)
                    const CircularProgressIndicator(
                        backgroundColor: Colors.black,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red))
                  else
                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.orange,
                            fixedSize:  Size.fromHeight(50),
                            textStyle: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            foregroundColor: Colors.white),
                        onPressed: () async {
                          _submit(context);
                        },
                        child: const Text('LOGIN'),
                      ),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

enum AuthenticationMode { Signup, Login }

class AuthWindow extends StatelessWidget {
  AuthWindow({super.key});

  final AuthenticationMode _authMode = AuthenticationMode.Login;
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 8.0,
      child: Container(
        height: _authMode == AuthenticationMode.Signup ? 400 : 400,
        constraints: BoxConstraints(
          minHeight: _authMode == AuthenticationMode.Signup ? 400 : 400,
        ),
        width: deviceSize.width * .75,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "User Id",
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
              keyboardType: TextInputType.emailAddress,
              onSaved: (String? value) {},
            )
          ]),
        ),
      ),
    );
  }
}

