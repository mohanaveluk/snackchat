class ChatDetailModel {
  String? status;
  String? message;
  List<ChatDetailData>? allData;

  ChatDetailModel({this.status, this.message, this.allData});

  ChatDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['allData'] != null) {
      allData = <ChatDetailData>[];
      json['allData'].forEach((v) {
        allData!.add(new ChatDetailData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.allData != null) {
      data['allData'] = this.allData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatDetailData {
  int? userinquiryid;
  int? userId;
  String? userFullName;
  String? email;
  String? mobile;
  int? receiverId;
  int? customeruserid;
  int? customerid;
  String? customername;
  String? customerlogopathurl;
  String? customerwebsiteurl;
  String? customerfacebookurl;
  String? cutomergooglebusinessurl;
  String? customerinstagramurl;
  String? customertwitterurl;
  String? customeryoutubeurl;
  String? membershipValidFrom;
  String? membershipValidTo;
  int? isverified;
  int? istrusted;
  List<Location>? location;
  String? initialLetter;
  List<Messages>? messages;

  ChatDetailData(
      {this.userinquiryid,
      this.userId,
      this.userFullName,
      this.email,
      this.mobile,
      this.receiverId,
      this.customeruserid,
      this.customerid,
      this.customername,
      this.customerlogopathurl,
      this.customerwebsiteurl,
      this.customerfacebookurl,
      this.cutomergooglebusinessurl,
      this.customerinstagramurl,
      this.customertwitterurl,
      this.customeryoutubeurl,
      this.membershipValidFrom,
      this.membershipValidTo,
      this.isverified,
      this.istrusted,
      this.location,
      this.initialLetter,
      this.messages});

  ChatDetailData.fromJson(Map<String, dynamic> json) {
    userinquiryid = json['userinquiryid'];
    userId = json['user_id'];
    userFullName = json['user_full_name'];
    email = json['email'];
    mobile = json['mobile'];
    receiverId = json['receiver_id'];
    customeruserid = json['customeruserid'];
    customerid = json['customerid'];
    customername = json['customername'];
    customerlogopathurl = json['customerlogopathurl'];
    customerwebsiteurl = json['customerwebsiteurl'];
    customerfacebookurl = json['customerfacebookurl'];
    cutomergooglebusinessurl = json['cutomergooglebusinessurl'];
    customerinstagramurl = json['customerinstagramurl'];
    customertwitterurl = json['customertwitterurl'];
    customeryoutubeurl = json['customeryoutubeurl'];
    membershipValidFrom = json['membership_valid_from'];
    membershipValidTo = json['membership_valid_to'];
    isverified = json['isverified'];
    istrusted = json['istrusted'];
    if (json['location'] != null) {
      location = <Location>[];
      json['location'].forEach((v) {
        location!.add(new Location.fromJson(v));
      });
    }
    initialLetter = json['initialLetter'];
    if (json['messages'] != null) {
      messages = <Messages>[];
      json['messages'].forEach((v) {
        messages!.add(new Messages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userinquiryid'] = this.userinquiryid;
    data['user_id'] = this.userId;
    data['user_full_name'] = this.userFullName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['receiver_id'] = this.receiverId;
    data['customeruserid'] = this.customeruserid;
    data['customerid'] = this.customerid;
    data['customername'] = this.customername;
    data['customerlogopathurl'] = this.customerlogopathurl;
    data['customerwebsiteurl'] = this.customerwebsiteurl;
    data['customerfacebookurl'] = this.customerfacebookurl;
    data['cutomergooglebusinessurl'] = this.cutomergooglebusinessurl;
    data['customerinstagramurl'] = this.customerinstagramurl;
    data['customertwitterurl'] = this.customertwitterurl;
    data['customeryoutubeurl'] = this.customeryoutubeurl;
    data['membership_valid_from'] = this.membershipValidFrom;
    data['membership_valid_to'] = this.membershipValidTo;
    data['isverified'] = this.isverified;
    data['istrusted'] = this.istrusted;
    if (this.location != null) {
      data['location'] = this.location!.map((v) => v.toJson()).toList();
    }
    data['initialLetter'] = this.initialLetter;
    if (this.messages != null) {
      data['messages'] = this.messages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Location {
  String? locationid;
  String? locationname;
  String? locationtype;
  String? address1;
  String? address2;
  String? city;
  String? state;

  Location({
    this.locationid,
    this.locationname,
    this.locationtype,
    this.address1,
    this.address2,
    this.city,
    this.state,
  });

  Location.fromJson(Map<String, dynamic> json) {
    locationid = json['locationid'];
    locationname = json['locationname'];
    locationtype = json['locationtype'];
    address1 = json['address1'];
    address2 = json['address2'];
    city = json['city'];
    state = json['state'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['locationid'] = this.locationid;
    data['locationname'] = this.locationname;
    data['locationtype'] = this.locationtype;
    data['address1'] = this.address1;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['state'] = this.state;

    return data;
  }
}

class Messages {
  String? date;
  List<ChatItem>? chatItem;

  Messages({this.date, this.chatItem});

  Messages.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['chatItem'] != null) {
      chatItem = <ChatItem>[];
      json['chatItem'].forEach((v) {
        chatItem!.add(new ChatItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.chatItem != null) {
      data['chatItem'] = this.chatItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatItem {
  int? chatid;
  int? sender;
  int? receiver;
  String? senderName;
  String? receiverName;
  String? direction;
  String? message;
  String? attachment;
  String? attachFilename;
  String? messageType;
  String? messagedatetime;
  String? formatedCreatedDate;
  String? formatedCreatedTime;
  String? formatedCreatedDatetime;
  String? createdDate;
  int? isRead;
  String? fileType;

  ChatItem(
      {this.chatid,
      this.sender,
      this.receiver,
      this.senderName,
      this.receiverName,
      this.direction,
      this.message,
      this.attachment,
      this.attachFilename,
      this.messageType,
      this.messagedatetime,
      this.formatedCreatedDate,
      this.formatedCreatedTime,
      this.formatedCreatedDatetime,
      this.createdDate,
      this.isRead,
      this.fileType});

  ChatItem.fromJson(Map<String, dynamic> json) {
    chatid = json['chatid'];
    sender = json['sender'];
    receiver = json['receiver'];
    senderName = json['sender_name'];
    receiverName = json['receiver_name'];
    direction = json['direction'];
    message = json['message'];
    attachment = json['attachment'];
    attachFilename = json['attach_filename'];
    messageType = json['message_type'];
    messagedatetime = json['messagedatetime'];
    formatedCreatedDate = json['formated_created_date'];
    formatedCreatedTime = json['formated_created_time'];
    formatedCreatedDatetime = json['formated_created_datetime'];
    createdDate = json['created_date'];
    isRead = json['is_read'];
    fileType = json['fileType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chatid'] = this.chatid;
    data['sender'] = this.sender;
    data['receiver'] = this.receiver;
    data['sender_name'] = this.senderName;
    data['receiver_name'] = this.receiverName;
    data['direction'] = this.direction;
    data['message'] = this.message;
    data['attachment'] = this.attachment;
    data['attach_filename'] = this.attachFilename;
    data['message_type'] = this.messageType;
    data['messagedatetime'] = this.messagedatetime;
    data['formated_created_date'] = this.formatedCreatedDate;
    data['formated_created_time'] = this.formatedCreatedTime;
    data['formated_created_datetime'] = this.formatedCreatedDatetime;
    data['created_date'] = this.createdDate;
    data['is_read'] = this.isRead;
    data['fileType'] = this.fileType;
    return data;
  }
}
