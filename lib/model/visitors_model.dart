import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gatekeeper/utils/colors.dart';

class GetActiveVisitors {
  GetActiveVisitors(
      {this.id,
      this.purpose,
      this.person,
      this.inTime,
      this.entryPass,
      this.visitingUnit,
      this.car,
      this.color});

  int? id;
  String? purpose;
  Person? person;
  String? inTime;
  String? entryPass;
  String? visitingUnit;
  Car? car;
  Color? color;

  factory GetActiveVisitors.fromJson(Map<String, dynamic> json) =>
      GetActiveVisitors(
          id: json["id"],
          purpose: json["purpose"],
          person: Person.fromJson(json["person"]),
          inTime: json["in_time"],
          entryPass: json["entry_pass"],
          visitingUnit: json["visiting_unit"],
          car: Car.fromJson(json["car"]),
          color: CommonColor()
              .colors[Random().nextInt(CommonColor().colors.length)]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "purpose": purpose,
        "person": person?.toJson(),
        "in_time": inTime,
        "entry_pass": entryPass,
        "visiting_units": visitingUnit,
        "car": car?.toJson(),
        "color": color
      };
}

class Car {
  Car({
    this.carPlate,
  });

  String? carPlate;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        carPlate: json["car_plate"],
      );

  Map<String, dynamic> toJson() => {
        "car_plate": carPlate,
      };
}

class Person {
  Person({
    this.nric,
    this.name,
    this.company,
    this.mobile,
  });

  String? nric;
  String? name;
  String? company;
  String? mobile;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        nric: json["nric"],
        name: json["name"],
        company: json["company"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "nric": nric,
        "name": name,
        "company": company,
        "mobile": mobile,
      };
}
