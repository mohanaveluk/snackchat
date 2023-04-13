import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snackchat/providers/chatuser.dart';
import 'package:snackchat/widgets/chat_item.dart';
import '../providers/chatusers.dart';

class ChatRoom extends StatelessWidget {
  const ChatRoom({super.key});

  @override
  Widget build(BuildContext context) {
    final allData = Provider.of<AllData>(context);
    final chatUserList = allData.rooms;

    return ListView.builder(
        itemCount: chatUserList!.length,
        itemBuilder: (ctx, i) => ChatItem(chatUserList[i]));
  }
}
