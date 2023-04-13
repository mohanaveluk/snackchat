import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/chat_detail_model.dart';
import 'package:http/http.dart' as _http;
import 'http_exception.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatDetail with ChangeNotifier {
  final String authToken;
  List<ChatDetailData> _chatDetailData = [];

  ChatDetail(this.authToken);

  List<ChatDetailData> get chatDetails {
    return [..._chatDetailData];
  }

  Future<void> fetchChatDetail1(String? senderId) async {
    print('fetchChatDetail is called ${senderId}');
  }

  Future<void> fetchChatDetail(
      senderId, receiverId, supplierId, stateCode, countryCode) async {
    _chatDetailData = [];
    final headers = {"Content-Type": "application/json"};
    final apiUrl = Uri.parse(
        'https://api.axelmart.com/api/v1/chat/history_customer_user?userid=${senderId}&receiverid=${receiverId}&customerid=${supplierId}&state=${stateCode}&countryCode=${countryCode}');
    final encoding = Encoding.getByName('utf-8');

    try {
      final loginResponse = await _http.get(apiUrl, headers: headers);
      final responseData = json.decode(loginResponse.body);
      if (responseData['status'] == null || responseData['status'] == '') {
        throw HttpException(responseData['message']);
      }

      if (responseData['status'] == 'true') {
        var __chatDetailData =
            ChatDetailData.fromJson(responseData['allData'][0]);
        _chatDetailData.add(__chatDetailData);
        notifyListeners();
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> sendMessage(message, chatRoom) async {
    var textToSend = true;
    var _guid = getGuid();

    final headers = {
      "Content-Type": "application/json",
      'Accept': 'application/json',
      "Authorization": "Bearer $authToken"
    };
    final apiUrl = Uri.parse(
        'https://api.axelmart.com/api/v1/chat/updateusersupplierinquiryhistory');

    final encoding = Encoding.getByName('utf-8');
    try {
      var _requestToSendMessage =
          await getSendMessageRequestEntity(message, chatRoom, _guid);

      final loginResponse = await _http.post(apiUrl,
          headers: headers, body: _requestToSendMessage, encoding: encoding);
      final responseData = json.decode(loginResponse.body);
      if (responseData['status'] == null || responseData['status'] == '') {
        throw HttpException(responseData['message']);
      }

      if (responseData['status'] == 'true') {
        await addMessageDetail(message, chatRoom, _guid);
        var sentStatus = 'Message has been sent';
        notifyListeners();
        return sentStatus;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  String getGuid() {
    var uuid = Uuid();
    // Generate a v4 (random) id
    var _guid = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
    return _guid;
  }

  Future<String> getSendMessageRequestEntity(
      message, selectedUserProfilePic, guid) async {
    var messageType = 'text';

    final userPref = await SharedPreferences.getInstance();
    var userData = userPref.getString('userData');
    final parseduserData = json.decode(userData!);
    final userId = parseduserData['userInfo']['user_id'];
    final firstName = parseduserData['userInfo']['first_name'];
    final lastName = parseduserData['userInfo']['last_name'];
    final userGuid = parseduserData['userInfo']['guid'];

    //var jsonRequest = '';
    var jsonRequest = json.encode({
      "requestUserSupplierInquiryHistory": {
        "id": 0,
        "inqueryid": selectedUserProfilePic["inquiry_id"],
        "inquirymappingid": 0,
        "senderuserid": selectedUserProfilePic["sender_id"],
        "receiveruserid": selectedUserProfilePic["receiver_id"],
        "conversation": 0,
        "conversationdir": "",
        "subject": "some Message",
        "messageType": messageType, // 'text', 'image', 'doc', 'video', 'audio'
        "message_type": messageType, // 'text', 'image', 'doc', 'video', 'audio'
        "message": message,
        "attachment": '',
        "file": null,
        "featureType": userGuid,
        "messageGuid": guid,
        "state": '0',
        "country": '0',
        "guid": userGuid
      }
    });

    return jsonRequest;
  }

  Future<void> addMessageDetail(
      message, selectedUserProfilePic, messageGuid) async {
    var currentDateTimeFormat = DateFormat('dd/MM/yyyy hh:mm');
    var currentDateFormat = DateFormat('dd/MM/yyyy');
    var currentTimeFormat = DateFormat('HH:mm');

    var currentDate = DateFormat.yMd().format(DateTime.now());
    var currentTime = DateFormat.jm().format(DateTime.now());
    var currentDateTime = currentDateTimeFormat.format(DateTime.now());

    var messageType = 'text';
    var chatDetail = _chatDetailData[0];
    final userPref = await SharedPreferences.getInstance();
    var userData = userPref.getString('userData');
    final parseduserData = json.decode(userData!);
    final userId = parseduserData['userInfo']['user_id'];
    final firstName = parseduserData['userInfo']['first_name'];
    final lastName = parseduserData['userInfo']['last_name'];
    final email = parseduserData['userInfo']['email'];
    final mobile = parseduserData['userInfo']['mobile'];
    final userGuid = parseduserData['userInfo']['guid'];

    var messageDetail = {
      'chatid': 100,
      'sender': selectedUserProfilePic["sender_id"],
      'receiver': selectedUserProfilePic["receiver_id"],
      'sender_name': selectedUserProfilePic["sender_name"],
      'receiver_name': selectedUserProfilePic["receiver_name"],
      'direction': '',
      'message': message,
      'attachment': '',
      'attach_filename': '',
      'message_type': messageType,
      'messagedatetime': currentDateTime,
      'formated_created_date': currentDate,
      'formated_created_time': currentTime,
      'formated_created_datetime': currentDateTime,
      'created_date': currentDate,
      'is_read': 0,
      'fileType': '',
    };
    var messageArray = _chatDetailData[0].messages;

    // var chatItemArray =
    //     messageArray!.any((element) => element.date!.toLowerCase() == 'today')
    //         ? messageArray
    //             .where((element) => element.date!.toLowerCase() == 'today')
    //             .toList()
    //         : null;

    messageArray![messageArray.length - 1]
        .chatItem
        ?.add(ChatItem.fromJson(messageDetail));
    // if (chatItemArray != null) {
    //   chatItemArray[0].chatItem?.add(ChatItem.fromJson(messageDetail));
    // } else {
    //   List<ChatItem> chatItemArr = [];

    //   chatItemArr.add(ChatItem.fromJson(messageDetail));
    //   Map<String, dynamic> messages = {
    //     "date": currentDate,
    //     "chatItem": chatItemArr
    //   };

    //   _chatDetailData[0].messages!.add(Messages.fromJson(messages));
    // }
  }
}
