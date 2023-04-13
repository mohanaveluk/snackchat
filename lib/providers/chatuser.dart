import 'package:flutter/material.dart';

class ChatUser with ChangeNotifier {
  String? status;
  String? message;
  AllData? allData;

  ChatUser({this.status, this.message, this.allData});

  ChatUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    allData =
        json['allData'] != null ? new AllData.fromJson(json['allData']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.allData != null) {
      data['allData'] = this.allData!.toJson();
    }
    return data;
  }
}

class AllData {
  int? id;
  String? name;
  String? initialLetter;
  List<Rooms>? rooms;

  AllData({this.id, this.name, this.initialLetter, this.rooms});

  AllData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    initialLetter = json['initialLetter'];
    if (json['rooms'] != null) {
      rooms = <Rooms>[];
      json['rooms'].forEach((v) {
        rooms!.add(new Rooms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['initialLetter'] = this.initialLetter;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//Model for chat use room
class Rooms {
  int? mappingId;
  int? inquiryId;
  int? senderId;
  int? receiverId;
  int? receiverSupplierId;
  String? senderName;
  String? receiverName;
  String? supplierName;
  int? supplierId;
  String? profilePicUrl;
  String? email;
  String? mobile;
  String? address1;
  String? address2;
  String? city;
  String? state;
  String? country;
  String? pincode;
  String? message;
  String? attachment;
  String? attachFilename;
  String? messageType;
  String? guid;
  String? createdon;
  String? formatedCreatedDatetime;
  int? unreadCount;
  String? formatedCreatedDate;
  String? formatedCreatedTime;
  String? initialLetter;

  Rooms(
      {this.mappingId,
      this.inquiryId,
      this.senderId,
      this.receiverId,
      this.receiverSupplierId,
      this.senderName,
      this.receiverName,
      this.supplierName,
      this.supplierId,
      this.profilePicUrl,
      this.email,
      this.mobile,
      this.address1,
      this.address2,
      this.city,
      this.state,
      this.country,
      this.pincode,
      this.message,
      this.attachment,
      this.attachFilename,
      this.messageType,
      this.guid,
      this.createdon,
      this.formatedCreatedDatetime,
      this.unreadCount,
      this.formatedCreatedDate,
      this.formatedCreatedTime,
      this.initialLetter});

  Rooms.fromJson(Map<String, dynamic> json) {
    mappingId = json['mapping_id'];
    inquiryId = json['inquiry_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    receiverSupplierId = json['receiver_supplier_id'];
    senderName = json['sender_name'];
    receiverName = json['receiver_name'];
    supplierName = json['supplier_name'];
    supplierId = json['supplier_id'];
    profilePicUrl = json['profile_pic_url'];
    email = json['email'];
    mobile = json['mobile'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
    message = json['message'];
    attachment = json['attachment'];
    attachFilename = json['attach_filename'];
    messageType = json['message_type'];
    guid = json['guid'];
    createdon = json['createdon'];
    formatedCreatedDatetime = json['formated_created_datetime'];
    unreadCount = json['unread_count'];
    formatedCreatedDate = json['formated_created_date'];
    formatedCreatedTime = json['formated_created_time'];
    initialLetter = json['initialLetter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mapping_id'] = this.mappingId;
    data['inquiry_id'] = this.inquiryId;
    data['sender_id'] = this.senderId;
    data['receiver_id'] = this.receiverId;
    data['receiver_supplier_id'] = this.receiverSupplierId;
    data['sender_name'] = this.senderName;
    data['receiver_name'] = this.receiverName;
    data['supplier_name'] = this.supplierName;
    data['supplier_id'] = this.supplierId;
    data['profile_pic_url'] = this.profilePicUrl;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    data['message'] = this.message;
    data['attachment'] = this.attachment;
    data['attach_filename'] = this.attachFilename;
    data['message_type'] = this.messageType;
    data['guid'] = this.guid;
    data['createdon'] = this.createdon;
    data['formated_created_datetime'] = this.formatedCreatedDatetime;
    data['unread_count'] = this.unreadCount;
    data['formated_created_date'] = this.formatedCreatedDate;
    data['formated_created_time'] = this.formatedCreatedTime;
    data['initialLetter'] = this.initialLetter;
    return data;
  }
}
