import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:snackchat/Screens/IndividualPage.dart';

import '../Screens/IndividualPage.dart';
import '../providers/chatuser.dart';
import 'dart:math' as math;

class ChatItem extends StatefulWidget {
  final Rooms chatRoom;
  ChatItem(this.chatRoom);

  @override
  State<ChatItem> createState() => _ChatItemState();
}

class _ChatItemState extends State<ChatItem> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5),
      child: Column(children: [
        ListTile(
          leading: widget.chatRoom.profilePicUrl != null &&
                  widget.chatRoom.profilePicUrl != ''
              ? CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      NetworkImage(widget.chatRoom.profilePicUrl.toString()),
                )
              : CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                  child: Text(
                    widget.chatRoom.supplierName!.toString().substring(0, 1),
                    style: const TextStyle(fontSize: 28, color: Colors.white),
                  ),
                ),
          title: Text(
            widget.chatRoom.supplierName != null &&
                    widget.chatRoom.supplierName != ''
                ? widget.chatRoom.supplierName.toString()
                : widget.chatRoom.receiverName.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              const Icon(
                Icons.done_all,
              ),
              SizedBox(
                width: 3,
              ),
              Text(
                widget.chatRoom.message.toString(),
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          trailing: Text(widget.chatRoom.formatedCreatedDatetime.toString()),
          onTap: () {
            Navigator.of(context).pushNamed(IndividualPage.routeName,
                arguments: widget.chatRoom.toJson());
          },
        ),
        // const Padding(
        //   padding: EdgeInsets.only(right: 10, left: 50),
        //   child: Divider(
        //     thickness: 0,
        //   ),
        // )
      ]),
    );
  }
}
