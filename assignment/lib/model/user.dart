class User {
  bool? success;
  Data? data;
  String? message;

  User({this.success, this.data, this.message});

  User.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  UserDetails? userDetails;
  String? token;

  Data({this.userDetails, this.token});

  Data.fromJson(Map<String, dynamic> json) {
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    data['token'] = this.token;
    return data;
  }
}

class UserDetails {
  int? id;
  String? name;
  String? fullName;
  String? email;
  String? mobileNo;
  Null? emailVerifiedAt;
  String? gender;
  String? dob;
  String? createdAt;
  String? updatedAt;

  UserDetails(
      {this.id,
      this.name,
      this.fullName,
      this.email,
      this.mobileNo,
      this.emailVerifiedAt,
      this.gender,
      this.dob,
      this.createdAt,
      this.updatedAt});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fullName = json['full_name'];
    email = json['email'];
    mobileNo = json['mobile_no'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['gender'];
    dob = json['dob'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['mobile_no'] = this.mobileNo;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}