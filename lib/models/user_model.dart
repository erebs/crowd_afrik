class UserModel {
  String? fullName;
  String? phoneNumber;
  String? emailId;
  String? deviceType;
  String? status;
  String? age;
  String? address;
  String? country;
  String? state;
  String? town;
  String? postCode;
  String? message;
  String? statusCode;

  UserModel(
      {this.fullName,
        this.phoneNumber,
        this.emailId,
        this.deviceType,
        this.status,
        this.age,
        this.address,
        this.country,
        this.state,
        this.town,
        this.postCode,
        this.message,
        this.statusCode});

  UserModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    phoneNumber = json['phone_number'];
    emailId = json['email_id'];
    deviceType = json['device_type'];
    status = json['status'];
    age = json['age'];
    address = json['address'];
    country = json['country'];
    state = json['state'];
    town = json['town'];
    postCode = json['post_code'];
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['phone_number'] = this.phoneNumber;
    data['email_id'] = this.emailId;
    data['device_type'] = this.deviceType;
    data['status'] = this.status;
    data['age'] = this.age;
    data['address'] = this.address;
    data['country'] = this.country;
    data['state'] = this.state;
    data['town'] = this.town;
    data['post_code'] = this.postCode;
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}
