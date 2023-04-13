import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../CustomUI/OwnMessageCard.dart';
import '../CustomUI/ReplyCard.dart';
import '../Model/chat_detail_model.dart';
import '../providers/chat_detail.dart';

class ChatDetailDay extends StatelessWidget {
  Messages _messages;
  int senderId;
  int receiverId;
  ChatDetailDay(this.senderId, this.receiverId, this._messages, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 140,
      // child: ListView.builder(
      //   itemCount: _messages.chatItem!.length,
      //   itemBuilder: (ctx, i) => _messages.chatItem![i].sender == senderId
      //       ? OwnMessageCard(_messages.chatItem![i])
      //       : ReplyCard(_messages.chatItem![i]),
      //),
      child: Text('Message ${_messages.date}'),
    );
  }
}
