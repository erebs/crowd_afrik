class CampaignsModel {
  List<Campaigns>? campaigns;
  String? message;
  String? statusCode;

  CampaignsModel({this.campaigns, this.message, this.statusCode});

  CampaignsModel.fromJson(Map<String, dynamic> json) {
    if (json['campaigns'] != null) {
      campaigns = <Campaigns>[];
      json['campaigns'].forEach((v) {
        campaigns!.add(new Campaigns.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.campaigns != null) {
      data['campaigns'] = this.campaigns!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Campaigns {
  int? id;
  String? title;
  int? fee;
  String? photo;
  String? description;
  var content1;
  var content2;
  String? icon;
  String? status;

  Campaigns(
      {this.id,
        this.title,
        this.fee,
        this.photo,
        this.description,
        this.content1,
        this.content2,
        this.icon,
        this.status});

  Campaigns.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    fee = json['fee'];
    photo = json['photo'];
    description = json['description'];
    content1 = json['content1'];
    content2 = json['content2'];
    icon = json['icon'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['fee'] = this.fee;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['content1'] = this.content1;
    data['content2'] = this.content2;
    data['icon'] = this.icon;
    data['status'] = this.status;
    return data;
  }
}
