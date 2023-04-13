import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as _http;
import './chatuser.dart';
import 'http_exception.dart';

class ChatUsers with ChangeNotifier {
  final String authToken;
  List<Rooms> _chatRoom = [];

  ChatUsers(this.authToken, this._chatRoom);

  List<Rooms> get rooms {
    return [..._chatRoom];
  }

  Future<void> fetchChatUsersToken(String aToken) async {
    final headers = {"Content-Type": "application/json"};

    final encoding = Encoding.getByName('utf-8');
    final userPref = await SharedPreferences.getInstance();
    var userData = userPref.getString('userData');
    final parseduserData = json.decode(userData!);
    final userId = parseduserData['userInfo']['user_id'];
    final firstName = parseduserData['userInfo']['first_name'];
    final lastName = parseduserData['userInfo']['last_name'];
    final apiUrl = Uri.parse(
        'https://api.axelmart.com/api/v1/chat/chatlist?userid=${userId}&reload=1');

    try {
      final loginResponse = await _http.get(apiUrl, headers: headers);
      final responseData = json.decode(loginResponse.body);
      if (responseData['status'] == null || responseData['status'] == '') {
        throw HttpException(responseData['message']);
      }

      if (responseData['status'] == 'true') {
        var allData = AllData.fromJson(responseData['allData']);
        _chatRoom = allData.rooms!;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> fetchChatUsers() async {
    try {
      print('token: ' + authToken);
      _chatRoom.add(Rooms(
          mappingId: 1,
          inquiryId: 1,
          senderId: 3,
          receiverId: 15,
          receiverSupplierId: 14,
          senderName: "Mohanavelu Kumarasamy",
          receiverName: "Lavanya lakshmi Mohanavelu",
          supplierName: "Palmo Fashion Designer",
          supplierId: 14,
          profilePicUrl: "",
          email: "rlavanyam@gmail.com",
          mobile: "+12103439315",
          address1: "",
          address2: "",
          city: "",
          state: "",
          country: "",
          pincode: "",
          message: "hi",
          messageType: "text",
          guid: "8925f982-cf31-4ee3-b8e5-de29a1097893",
          createdon: "2023-01-09T09:24:28.000Z",
          formatedCreatedDatetime: "01/09/2023 09:24",
          unreadCount: 0,
          formatedCreatedDate: "01/09/2023",
          formatedCreatedTime: "3:24 AM",
          initialLetter: "P"));
      notifyListeners();
    } catch (e) {
      print('token error');
    }
  }
}
