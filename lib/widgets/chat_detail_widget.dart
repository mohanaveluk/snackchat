import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../CustomUI/OwnMessageCard.dart';
import '../CustomUI/ReplyCard.dart';
import '../Model/chat_detail_model.dart';
import '../providers/chat_detail.dart';
import 'chat_detail_day.dart';

class ChatDetailWidget extends StatelessWidget {
  int senderId;
  int receiverId;

  ChatDetailWidget(this.senderId, this.receiverId);
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    List<Messages> __message = [];
    var chatDetail =
        Provider.of<ChatDetail>(context, listen: false).chatDetails;
    List<Messages> messages = (chatDetail != null && chatDetail.length > 0
        ? chatDetail[0].messages
        : __message) as List<Messages>;
    print("${senderId}, ${receiverId} ");

    return Container(
      height: MediaQuery.of(context).size.height - 140,
      child: ListView.builder(
        controller: _controller,
        shrinkWrap: true,
        primary: false,
        itemCount: messages.length,
        // itemBuilder: (ctx, i) => messages[i].chatItem != null &&
        //         messages[i].chatItem![0].sender == senderId
        //     ? OwnMessageCard(messages[i].chatItem![0])
        //     : ReplyCard(messages[i].chatItem![0]),

        // itemBuilder: (ctx, i) {
        //   //ChatDetailDay(senderId, receiverId, messages[i]),
        //   return Column(
        //     children: [
        //       ListTile(
        //         title: Center(
        //           child: Text(
        //             "${messages[i].date}",
        //             style: const TextStyle(fontSize: 10),
        //           ),
        //         ),
        //       ),
        //       ListTile(
        //         title: Text(messages[i].chatItem!.length.toString()),
        //       ),
        //       // Container(
        //       //     height: MediaQuery.of(context).size.height - 150,
        //       //     child: Text(messages[i].chatItem!.length.toString())),
        //     ],
        //   );
        // }
        itemBuilder: (ctx, i) => Column(
          children: [
            ListTile(
              title: Center(
                child: Text(
                  "${messages[i].date}",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: messages[i].chatItem!.length,
              itemBuilder: (BuildContext context, int qIndex) {
                // return ListTile(
                //     title: Text('${messages[i].chatItem![qIndex].message}'));
                return senderId == messages[i].chatItem![qIndex].sender
                    ? OwnMessageCard(messages[i].chatItem![qIndex])
                    : ReplyCard(messages[i].chatItem![qIndex]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
