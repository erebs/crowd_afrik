class RegModel {
  String? message;
  String? fullName;
  String? phoneNumber;
  String? emailId;
  String? statusCode;

  RegModel(
      {this.message,
        this.fullName,
        this.phoneNumber,
        this.emailId,
        this.statusCode});

  RegModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    emailId = json['email_id'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['email_id'] = this.emailId;
    data['status_code'] = this.statusCode;
    return data;
  }
}
