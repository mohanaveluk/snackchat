import 'package:flutter/material.dart';
import 'package:snackchat/pages/chatPage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static const routeName = '/chat';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late TabController _Controller;

  @override
  void initState() {
    super.initState();
    _Controller = TabController(length: 1, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          icon: Icon(
            Icons.fastfood,
            size: 45,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {},
          ),
          PopupMenuButton<String>(onSelected: (value) {
            print(5);
          }, itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem(
                child: Text("Settings"),
                value: "Settings",
              ),
            ];
          })
        ],
        bottom: TabBar(
          controller: _Controller,
          indicatorColor: Colors.white,
          tabs: [
            Tab(
              text: "status",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _Controller,
        children: [
          chatPage(),
        ],
      ),
    );
  }
}
