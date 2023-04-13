import 'package:flutter/material.dart';
import 'package:snackchat/CustomUI/CustomCard.dart';
import 'package:snackchat/Model/ChatModel.dart';

class chatPage extends StatefulWidget {
  @override
  State<chatPage> createState() => _chatPageState();
}

class _chatPageState extends State<chatPage> {
  /*
  List<ChatModel> Chats = [
    ChatModel(
      name: "Nimalan",
      isGroup: false,
      currentMessage: "Hi Dude",
      time: "5.00",
      icon: "persons.svg",
    ),
    ChatModel(
      name: "Priya",
      isGroup: false,
      currentMessage: "Hi Dude",
      time: "5.00",
      icon: "persons.svg",
    ),
    ChatModel(
      name: "Sadh",
      isGroup: false,
      currentMessage: "Hi sadh",
      time: "4 .00",
      icon: "persons.svg",
    ),
    ChatModel(
      name: "Santhosh",
      isGroup: false,
      currentMessage: "Hi Dude",
      time: "6.00",
      icon: "persons.svg",
    ),
    ChatModel(
      name: "Family",
      isGroup: true,
      currentMessage: "Hi All",
      time: "7.00",
      icon: "persons.svg",
    ),
  ];
  */
  @override
  Widget build(BuildContext context) {
    var chats;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.chat),
      ),
      body: ListView(
        children: const [
          //  CustomCard(),
          //  CustomCard(),
          //  CustomCard(),
          //  CustomCard(),
          Card(
            child: Text('Chart page'),
          )
        ],
      ),
    );
  }
}
