// To parse this JSON data, do
//
//     final allUser = allUserFromJson(jsonString);

import 'dart:convert';

AllUser allUserFromJson(String str) => AllUser.fromJson(json.decode(str));

String allUserToJson(AllUser data) => json.encode(data.toJson());

class AllUser {
  AllUser({
    this.id,
    this.name,
    this.name_lc,
    this.age,
    this.bloodGroup,
    this.district,
    this.mobile,
    this.donationDate,
    this.createdAt
  });

  String? id;
  String? name;
  String? name_lc;
  String? age;
  String? bloodGroup;
  String? district;
  String? mobile;
  String? donationDate;
  int? createdAt;

  factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
    id: json["id"],
    name: json["name"],
    name_lc: json["name_lc"],
    age: json["age"],
    bloodGroup: json["bloodGroup"],
    district: json["district"],
    mobile: json["mobile"],
    donationDate: json["donation_date"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_lc": name_lc,
    "age": age,
    "bloodGroup": bloodGroup,
    "district": district,
    "mobile": mobile,
    "donation_date": donationDate,
    "createdAt": createdAt,
  };
}
