class DeleteModel {
  String? message;
  String? statusCode;

  DeleteModel({this.message, this.statusCode});

  DeleteModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}