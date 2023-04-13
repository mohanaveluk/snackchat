import 'dart:convert';

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as _http;
import 'package:shared_preferences/shared_preferences.dart';

class UserAuthentication with ChangeNotifier {
  String? _token;
  String _expiryDate =
      DateTime.now().add(const Duration(hours: 4)).toIso8601String();

  Future<String> get isAuth async {
    await Future.delayed(Duration(seconds: 2));
    return token != null ? 'true' : 'false';
  }

  String? get token {
    var expiryDate = DateTime.parse(_expiryDate.toString());
    // ignore: unnecessary_null_comparison
    if (_expiryDate != null &&
        expiryDate.isAfter(DateTime.now()) &&
        // ignore: unnecessary_null_comparison
        _token != null) {
      return _token;
    }

    return null;
  }

  Future<String> userSignIn2(email, password) async {
    final headers = {"Content-Type": "application/json"};
    final apiUrl = Uri.parse('https://api.axelmart.com/api/v1/user/signin');
    final encoding = Encoding.getByName('utf-8');
    final inputObject = json.encode({
      "signinInfo": {"email": email, "password": password}
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
        userPref.setString('userData', userData);
        //Navigator.of(context).pushReplacementNamed('/chat');
        //notifyListeners();
        return responseData['token'];
      } else {
        throw HttpException(responseData['message']);
      }
    } catch (e) {
      // ignore: use_rethrow_when_possible
      throw e.toString();
    }
  }
}
