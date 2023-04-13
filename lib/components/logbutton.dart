import 'package:flutter/material.dart';

import '../Screens/ChatScreen.dart';

class logbutton extends StatelessWidget {

  final Function()? onTap;

  const logbutton({Key? key, this.onTap}) : super(key: key);
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
            child: Text("Log In",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      onTap: (){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ChatScreen()));
      },
    );

  }
}



