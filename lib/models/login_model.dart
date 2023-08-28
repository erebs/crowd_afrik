class LoginModel {
  int? userId;
  String? token;
  String? fullName;
  String? emailId;
  String? message;
  String? statusCode;

  LoginModel(
      {this.userId,
        this.token,
        this.fullName,
        this.emailId,
        this.message,
        this.statusCode});

  LoginModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    token = json['token'];
    fullName = json['full_name'];
    emailId = json['email_id'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['token'] = this.token;
    data['full_name'] = this.fullName;
    data['email_id'] = this.emailId;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}
