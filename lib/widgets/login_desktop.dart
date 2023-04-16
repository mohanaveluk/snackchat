import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../NewScreen/userlogin.dart';
import '../Screens/chat_home_screen.dart';
import '../providers/http_exception.dart';
import '../providers/userAuthentication.dart';

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({super.key});

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
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
    return Row(
      children: [
        Expanded(
            //<-- Expanded widget
            child: Image.asset(
          'assets/images/20220705214853_IMG_1570.JPG',
          fit: BoxFit.cover,
        )),
        Expanded(
          //<-- Expanded widget
          child: Container(
            constraints: const BoxConstraints(maxWidth: 21),
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Login to your account',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 35),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 14, 3, 3)),

                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromARGB(255, 104, 102, 102)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    // Set border for focused state
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromARGB(255, 104, 102, 102)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: _nameFocusNode,
                ),
                const SizedBox(height: 20),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 14, 3, 3)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromARGB(255, 104, 102, 102)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    // Set border for focused state
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          width: 3, color: Color.fromARGB(255, 104, 102, 102)),
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    focusNode: _passwordFocusNode,
                ),

                const SizedBox(height: 20),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 43, 198, 48),
                      fixedSize: Size.fromHeight(50),
                      textStyle: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      foregroundColor: Colors.white),
                  onPressed: () {},
                  child: const Text('LOGIN'),
                ),
                const SizedBox(height: 15),
                //TextButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
