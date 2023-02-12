class ManualInputCarInDetails {
  PedestrianDetail? pedestrianDetail;
  Photo? photo;

  ManualInputCarInDetails({this.pedestrianDetail, this.photo});

  ManualInputCarInDetails.fromJson(Map<String, dynamic> json) {
    pedestrianDetail = (json['PedestrianDetail'] != null
        ? PedestrianDetail.fromJson(json['PedestrianDetail'])
        : null)!;
    photo = (json['Photo:'] != null ? Photo.fromJson(json['Photo:']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pedestrianDetail != null) {
      data['PedestrianDetail'] = pedestrianDetail!.toJson();
    }
    if (photo != null) {
      data['Photo:'] = photo!.toJson();
    }
    return data;
  }
}

class PedestrianDetail {
  int? id;
  Person? person;
  Car? car;
  dynamic container;
  String? entryPass;
  String? purpose;
  String? visitingUnit;
  String? inTime;
  dynamic outTime;
  int? duration;
  dynamic photo;
  String? remarks;
  dynamic temperature;
  bool? preRegistered;
  bool? respiratory;
  bool? agreement;
  dynamic agreementDate;
  String? postingDate;
  int? site;

  PedestrianDetail(
      {this.id,
      this.person,
      this.car,
      this.container,
      this.entryPass,
      this.purpose,
      this.visitingUnit,
      this.inTime,
      this.outTime,
      this.duration,
      this.photo,
      this.remarks,
      this.temperature,
      this.preRegistered,
      this.respiratory,
      this.agreement,
      this.agreementDate,
      this.postingDate,
      this.site});

  PedestrianDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    person = json['person'] != null ? Person.fromJson(json['person']) : null;
    car = json['car'] != null ? Car.fromJson(json['car']) : null;
    container = json['container'];
    entryPass = json['entry_pass'];
    purpose = json['purpose'];
    visitingUnit = json['visiting_unit'];
    inTime = json['in_time'];
    outTime = json['out_time'];
    duration = json['duration'];
    photo = json['photo'];
    remarks = json['remarks'];
    temperature = json['temperature'];
    preRegistered = json['pre_registered'];
    respiratory = json['respiratory'];
    agreement = json['agreement'];
    agreementDate = json['agreement_date'];
    postingDate = json['posting_date'];
    site = json['site'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (person != null) {
      data['person'] = person!.toJson();
    }
    if (car != null) {
      data['car'] = car!.toJson();
    }
    data['container'] = container;
    data['entry_pass'] = entryPass;
    data['purpose'] = purpose;
    data['visiting_unit'] = visitingUnit;
    data['in_time'] = inTime;
    data['out_time'] = outTime;
    data['duration'] = duration;
    data['photo'] = photo;
    data['remarks'] = remarks;
    data['temperature'] = temperature;
    data['pre_registered'] = preRegistered;
    data['respiratory'] = respiratory;
    data['agreement'] = agreement;
    data['agreement_date'] = agreementDate;
    data['posting_date'] = postingDate;
    data['site'] = site;
    return data;
  }
}

class Person {
  String? nric;
  String? name;
  String? company;
  String? mobile;

  Person({this.nric, this.name, this.company, this.mobile});

  Person.fromJson(Map<String, dynamic> json) {
    nric = json['nric'];
    name = json['name'];
    company = json['company'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nric'] = nric;
    data['name'] = name;
    data['company'] = company;
    data['mobile'] = mobile;
    return data;
  }
}

class Car {
  String? carPlate;

  Car({this.carPlate});

  Car.fromJson(Map<String, dynamic> json) {
    carPlate = json['car_plate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['car_plate'] = carPlate;
    return data;
  }
}

class Photo {
  dynamic personPhoto;
  dynamic carPhoto;

  Photo({this.personPhoto, this.carPhoto});

  Photo.fromJson(Map<String, dynamic> json) {
    personPhoto = json['person_photo'];
    carPhoto = json['car_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['person_photo'] = personPhoto;
    data['car_photo'] = carPhoto;
    return data;
  }
}
