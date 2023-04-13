import 'dart:convert';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class userAccount with ChangeNotifier {
  String? status = '';
  String? message = '';
  User? user;
  String? token = '';
  String? refreshToken = '';

  userAccount({
    required this.status, 
    required this.message, 
    required this.user, 
    required this.token, 
    required this.refreshToken
  });

/*
  user_auth.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['token'] = this.token;
    data['refreshToken'] = this.refreshToken;
    return data;
  }
*/

}


class User {
  int? userId;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  String? mobile;
  String? address1;
  String? address2;
  String? city;
  Null? stateId;
  Null? stateCode;
  Null? stateName;
  Null? countryId;
  Null? countryCode;
  Null? countryName;
  String? profilePicUrl;
  int? isMobileVerified;
  int? isEmailVerified;
  int? isRegistered;
  String? signType;
  String? createdon;
  String? formatedCreatedon;
  String? userGuid;
  String? roleGuid;
  String? supplierGuid;
  String? supplierName;
  String? guid;

  User(
      {this.userId,
      this.firstName,
      this.lastName,
      this.fullName,
      this.email,
      this.mobile,
      this.address1,
      this.address2,
      this.city,
      this.stateId,
      this.stateCode,
      this.stateName,
      this.countryId,
      this.countryCode,
      this.countryName,
      this.profilePicUrl,
      this.isMobileVerified,
      this.isEmailVerified,
      this.isRegistered,
      this.signType,
      this.createdon,
      this.formatedCreatedon,
      this.userGuid,
      this.roleGuid,
      this.supplierGuid,
      this.supplierName,
      this.guid});


}