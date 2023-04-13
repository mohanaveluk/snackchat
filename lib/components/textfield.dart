import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  const textfield({Key? key, this.controller, required this.hintText, required this.obscureText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.orange.shade700
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            fillColor: Colors.white60,
            filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),

        ),
      ),
    );
  }
}



