import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import '../providers/chatusers.dart';
import '../widgets/chat_item.dart';

class ChatHome extends StatefulWidget {
  static const routeName = '/chat_home';
  ChatHome(this.jwt, this.payload);

  factory ChatHome.fromBase64(String jwt) => ChatHome(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  final String jwt;
  final Map<String, dynamic> payload;
  
  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
    //SchedulerBinding.instance.scheduleFrameCallback((timeStamp) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<ChatUsers>(context, listen: false)
          .fetchChatUsersToken(widget.jwt);
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatUsers = Provider.of<ChatUsers>(context);
    final rooms = chatUsers.rooms;

    
    return Scaffold(
      appBar: AppBar(
        title: Text("SnackChat"),
        automaticallyImplyLeading: false,
        actions: [
          PopupMenuButton<String>(itemBuilder:(BuildContext context){
            return[
              const PopupMenuItem(child: Text("Log out"))
            ];
          }),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: rooms.length,
              itemBuilder: (ctx, i) => ChatItem(rooms[i])),
              

              
    );
  
  }
}
