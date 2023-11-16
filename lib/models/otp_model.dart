class OtpModel {
  String? message;
  int? otp;
  String? statusCode;

  OtpModel({this.message, this.otp, this.statusCode});

  OtpModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    otp = json['otp'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['otp'] = this.otp;
    data['status_code'] = this.statusCode;
    return data;
  }
}
