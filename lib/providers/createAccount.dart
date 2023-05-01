import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as _http;
import 'package:shared_preferences/shared_preferences.dart';

class CreateAccount with ChangeNotifier {
  String? _token;
  String _expiryDate =
      DateTime.now().add(const Duration(hours: 4)).toIso8601String();

  Future<String> createUserAccount(
      userFirstName, userLastName, email, mobile, password) async {
    final headers = {"Content-Type": "application/json"};
    final apiUrl = Uri.parse('https://api.axelmart.com/api/v1/user/update');
    final encoding = Encoding.getByName('utf-8');

    final inputObject = json.encode({
      "requestuser": {
        "id": 0,
        "email": email,
        "password": password,
        "firstname": userFirstName,
        "lastname": userLastName,
        "mobile": mobile,
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
        final userData = jsonEncode({
          "user_model": _token,
          "user_guid": _userGuid,
          "verification_message": _verificationMessage
        });

        userPref.setString('userData', userData);
        return userData;
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
