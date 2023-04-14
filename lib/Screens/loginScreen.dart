import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import '../widgets/login_desktop.dart';
import '../widgets/login_mobile.dart';
import '../widgets/login_tablet.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return const LoginMobile();
        } else if (constraints.maxWidth > 600 && constraints.maxWidth < 900) {
          return const LoginTablet();
        } else {
          return const LoginDesktop();
        }
      }),
    );
  }
}
