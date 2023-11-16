class CheckModel {
  String? message;
  int? otp;
  String? statusCode;
  Result? result;

  CheckModel({this.message, this.otp, this.statusCode, this.result});

  CheckModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    otp = json['otp'];
    statusCode = json['status_code'];
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['otp'] = this.otp;
    data['status_code'] = this.statusCode;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? status;
  Data? data;

  Result({this.status, this.data});

  Result.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  SMSMessageData? sMSMessageData;

  Data({this.sMSMessageData});

  Data.fromJson(Map<String, dynamic> json) {
    sMSMessageData = json['SMSMessageData'] != null
        ? new SMSMessageData.fromJson(json['SMSMessageData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sMSMessageData != null) {
      data['SMSMessageData'] = this.sMSMessageData!.toJson();
    }
    return data;
  }
}

class SMSMessageData {
  String? message;
  List<Recipients>? recipients;

  SMSMessageData({this.message, this.recipients});

  SMSMessageData.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    if (json['Recipients'] != null) {
      recipients = <Recipients>[];
      json['Recipients'].forEach((v) {
        recipients!.add(new Recipients.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Message'] = this.message;
    if (this.recipients != null) {
      data['Recipients'] = this.recipients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Recipients {
  String? cost;
  String? messageId;
  String? number;
  String? status;
  int? statusCode;

  Recipients(
      {this.cost, this.messageId, this.number, this.status, this.statusCode});

  Recipients.fromJson(Map<String, dynamic> json) {
    cost = json['cost'];
    messageId = json['messageId'];
    number = json['number'];
    status = json['status'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cost'] = this.cost;
    data['messageId'] = this.messageId;
    data['number'] = this.number;
    data['status'] = this.status;
    data['statusCode'] = this.statusCode;
    return data;
  }
}
