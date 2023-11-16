class CategoryModel {
  List<Categories>? categories;
  int? activeCampaigns;
  List<PendingApplications>? pendingApplications;
  String? message;
  String? statusCode;

  CategoryModel(
      {this.categories,
        this.activeCampaigns,
        this.pendingApplications,
        this.message,
        this.statusCode});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(new Categories.fromJson(v));
      });
    }
    activeCampaigns = json['active_campaigns'];
    if (json['pending_applications'] != null) {
      pendingApplications = <PendingApplications>[];
      json['pending_applications'].forEach((v) {
        pendingApplications!.add(new PendingApplications.fromJson(v));
      });
    }
    message = json['message'];
    statusCode = json['status_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories!.map((v) => v.toJson()).toList();
    }
    data['active_campaigns'] = this.activeCampaigns;
    if (this.pendingApplications != null) {
      data['pending_applications'] =
          this.pendingApplications!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
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

class PendingApplications {
  int? id;
  String? userId;
  String? campaignId;
  int? isSpecial;
  var plan;
  var location;
  var address;
  var post;
  var localArea;
  String? countryId;
  String? stateId;
  var plot;
  var annualTurnover;
  String? paymentStatus;
  var amount;
  var paymentDate;
  var referenceId;
  var nominee1;
  var mobile1;
  var nominee2;
  var mobile2;
  var nominee3;
  var mobile3;
  var nominee4;
  var mobile4;
  var nominee5;
  var mobile5;
  String? status;
  var blockReason;
  var blockedBy;
  String? createdAt;
  String? updatedAt;

  PendingApplications(
      {this.id,
        this.userId,
        this.campaignId,
        this.isSpecial,
        this.plan,
        this.location,
        this.address,
        this.post,
        this.localArea,
        this.countryId,
        this.stateId,
        this.plot,
        this.annualTurnover,
        this.paymentStatus,
        this.amount,
        this.paymentDate,
        this.referenceId,
        this.nominee1,
        this.mobile1,
        this.nominee2,
        this.mobile2,
        this.nominee3,
        this.mobile3,
        this.nominee4,
        this.mobile4,
        this.nominee5,
        this.mobile5,
        this.status,
        this.blockReason,
        this.blockedBy,
        this.createdAt,
        this.updatedAt});

  PendingApplications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    campaignId = json['campaign_id'];
    isSpecial = json['is_special'];
    plan = json['plan'];
    location = json['location'];
    address = json['address'];
    post = json['post'];
    localArea = json['local_area'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    plot = json['plot'];
    annualTurnover = json['annual_turnover'];
    paymentStatus = json['payment_status'];
    amount = json['amount'];
    paymentDate = json['payment_date'];
    referenceId = json['reference_id'];
    nominee1 = json['nominee1'];
    mobile1 = json['mobile1'];
    nominee2 = json['nominee2'];
    mobile2 = json['mobile2'];
    nominee3 = json['nominee3'];
    mobile3 = json['mobile3'];
    nominee4 = json['nominee4'];
    mobile4 = json['mobile4'];
    nominee5 = json['nominee5'];
    mobile5 = json['mobile5'];
    status = json['status'];
    blockReason = json['block_reason'];
    blockedBy = json['blocked_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['campaign_id'] = this.campaignId;
    data['is_special'] = this.isSpecial;
    data['plan'] = this.plan;
    data['location'] = this.location;
    data['address'] = this.address;
    data['post'] = this.post;
    data['local_area'] = this.localArea;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['plot'] = this.plot;
    data['annual_turnover'] = this.annualTurnover;
    data['payment_status'] = this.paymentStatus;
    data['amount'] = this.amount;
    data['payment_date'] = this.paymentDate;
    data['reference_id'] = this.referenceId;
    data['nominee1'] = this.nominee1;
    data['mobile1'] = this.mobile1;
    data['nominee2'] = this.nominee2;
    data['mobile2'] = this.mobile2;
    data['nominee3'] = this.nominee3;
    data['mobile3'] = this.mobile3;
    data['nominee4'] = this.nominee4;
    data['mobile4'] = this.mobile4;
    data['nominee5'] = this.nominee5;
    data['mobile5'] = this.mobile5;
    data['status'] = this.status;
    data['block_reason'] = this.blockReason;
    data['blocked_by'] = this.blockedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
