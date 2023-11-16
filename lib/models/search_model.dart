class SearchModel {
  List<Categories>? categories;
  List<Campaigns>? campaigns;
  String? statusCode;

  SearchModel({this.categories, this.campaigns, this.statusCode});

  SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['campaigns'] != null) {
      campaigns = <Campaigns>[];
      json['campaigns'].forEach((v) {
        campaigns!.add(new Campaigns.fromJson(v));
      });
    }
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    if (this.campaigns != null) {
      data['campaigns'] = this.campaigns!.map((v) => v.toJson()).toList();
    }
    data['status_code'] = this.statusCode;
    return data;
  }
}

class Categories {
  int? id;
  String? title;
  String? photo;
  String? description;
  String? icon;
  String? status;

  Categories(
      {this.id,
        this.title,
        this.photo,
        this.description,
        this.icon,
        this.status});

  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    photo = json['photo'];
    description = json['description'];
    icon = json['icon'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['photo'] = this.photo;
    data['description'] = this.description;
    data['icon'] = this.icon;
    data['status'] = this.status;
    return data;
  }
}

class Campaigns {
  int? id;
  String? title;
  int? fee;
  String? photo;
  String? description;
  String? content1;
  String? content2;
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
