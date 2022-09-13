// To parse this JSON data, do
//
//     final hospitalModel = hospitalModelFromJson(jsonString);

import 'dart:convert';

HospitalModel hospitalModelFromJson(String str) => HospitalModel.fromJson(json.decode(str));

String hospitalModelToJson(HospitalModel data) => json.encode(data.toJson());

class HospitalModel {
  HospitalModel({
    this.hospitalName,
    this.icuBed,
    this.phone,
  });

  String? hospitalName;
  String? icuBed;
  String? phone;

  factory HospitalModel.fromJson(Map<String, dynamic> json) => HospitalModel(
    hospitalName: json["hospital_name"],
    icuBed: json["icu_bed"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "hospital_name": hospitalName,
    "icu_bed": icuBed,
    "phone": phone,
  };
}
