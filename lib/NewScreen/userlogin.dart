import 'package:flutter/material.dart';
import '../Screens/chat_home_screen.dart';
import '../providers/http_exception.dart';
import '../providers/userAuthentication.dart';
import 'package:snackchat/NewScreen/LoginPage.dart';
import 'package:provider/provider.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  get height => 90;
  final AuthenticationMode _authMode = AuthenticationMode.Login;
  final _form = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final _nameFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Map<String, String> _authData = {'email': '', 'password': ''};
  bool _isLoading = false;
  get hintText => null;

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
      body: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 8.0,
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 40),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 40.0),
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
                      'Login',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'Anton',
                          color: Colors.white70,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "User Id",
                    fillColor: Colors.white60,
                    filled: true,
                    hintText: hintText,
                    hintStyle: TextStyle(color: Color.fromARGB(255, 14, 3, 3)),
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
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    fillColor: Colors.white60,
                    filled: true,
                    hintText: hintText,
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 14, 3, 3)),
                  ),
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  keyboardType: TextInputType.text,
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
                const SizedBox(
                  height: 25,
                ),
                if (_isLoading)
                  const CircularProgressIndicator(
                      backgroundColor: Colors.black,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red))
                else
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton(
                        onPressed: () async {
                          _submit(context);
                        },
                        child: const Text("Submit")),
                  ),
                const SizedBox(
                  height: 30,
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                    )
                  ],
                ),
              ],
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
