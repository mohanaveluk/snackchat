import 'package:flutter/material.dart';

import '../Screens/ChatScreen.dart';

class button extends StatelessWidget {

  final Function()? onTap;

  const button({Key? key, this.onTap}) : super(key: key);
  
  
  get snackBar => null;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.symmetric(horizontal: 100),
          decoration: BoxDecoration(
              color: Colors.orange[700],
          borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text("Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            ),
          ),
        ),
      ),
      onTap: (){},
    );

  }
}



