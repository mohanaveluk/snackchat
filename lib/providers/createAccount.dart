import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as _http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount with ChangeNotifier {
  String? _token = '';
  String _expiryDate =
      DateTime.now().add(const Duration(hours: 4)).toIso8601String();

  Future<Map<String, dynamic>> createUserAccount(
      userFirstName, userLastName, email, mobile, password) async {
    final headers = {"Content-Type": "application/json"};
    final apiUrl = Uri.parse('https://api.axelmart.com/api/v1/user/update');
    final encoding = Encoding.getByName('utf-8');

    final inputObject = json.encode({
      "requestuser": {
        "id": 0,
        "firstname": userFirstName,
        "lastname": userLastName,
        "roleid": 2,
        "email": email,
        "password": password,
        "mobile": mobile,
        "address1": "",
        "address2": "",
        "pincode": "",
        "city": "",
        "stateName": "",
        "countryCode": "",
        "profilepicurl": "",
        "guid": "",
        "ismobileverified": 0,
        "isemailverified": 0
      }
    });

    try {
      final loginResponse = await _http.post(apiUrl,
          headers: headers, body: inputObject, encoding: encoding);
      final responseData = json.decode(loginResponse.body);
      if (responseData['status'] == null || responseData['status'] == '') {
        throw HttpException(responseData['message']);
      }
      if (responseData['status'] == 'true') {
        final _registeredUserModel = responseData['account'];
        final _userGuid = responseData['account']['user_guid'];
        final _verificationMessage = responseData['message'];

        final userPref = await SharedPreferences.getInstance();
        final userData = {
          "user_model": _registeredUserModel,
          "userInfo": {
            "user_id": _registeredUserModel['id'],
            "first_name": "",
            "last_name": "",
          },
          "user_guid": _userGuid,
          "verification_message": _verificationMessage,
          "message": responseData['message']
        };
        userPref.setString('userData', jsonEncode(userData));

        return userData;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<String> submitVerifictionCode(guid, code) async {
    final headers = {"Content-Type": "application/json"};
    final apiUrl = Uri.parse('https://api.axelmart.com/api/v1/user/verifyotp');
    final encoding = Encoding.getByName('utf-8');

    final inputObject = json.encode({
      "requestuserotphistory": {
        "userId": 0,
        "accountId": guid,
        "enteredOTP": code,
        "device": 'M'
      }
    });

    try {
      final loginResponse = await _http.post(apiUrl,
          headers: headers, body: inputObject, encoding: encoding);
      final responseData = json.decode(loginResponse.body);
      if (responseData['status'] == null || responseData['status'] == '') {
        throw HttpException(responseData['message']);
      }
      if (responseData['status'] == 'true') {
        _token = responseData['token'];
        _expiryDate =
            DateTime.now().add(const Duration(hours: 4)).toIso8601String();
        final userPref = await SharedPreferences.getInstance();

        final userData = jsonEncode({
          "token": _token,
          "userInfo": responseData['user'],
          "refreshToken": responseData['refreshToken'],
          "expiryDate": _expiryDate
        });

        return _token as dynamic;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
