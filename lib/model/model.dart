// To parse this JSON data, do
//
//     final fakeStoreApi = fakeStoreApiFromJson(jsonString);

import 'dart:convert';

List<FakeStoreApi> fakeStoreApiFromJson(String str) => List<FakeStoreApi>.from(
    json.decode(str).map((x) => FakeStoreApi.fromJson(x)));

String fakeStoreApiToJson(List<FakeStoreApi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FakeStoreApi {
  Address? address;
  int? id;
  String? email;
  String? username;
  String? password;
  Name? name;
  String? phone;
  int? v;

  FakeStoreApi({
    this.address,
    this.id,
    this.email,
    this.username,
    this.password,
    this.name,
    this.phone,
    this.v,
  });

  factory FakeStoreApi.fromJson(Map<String, dynamic> json) => FakeStoreApi(
        address:
            json["address"] == null ? null : Address.fromJson(json["address"]),
        id: json["id"],
        email: json["email"],
        username: json["username"],
        password: json["password"],
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        phone: json["phone"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "address": address?.toJson(),
        "id": id,
        "email": email,
        "username": username,
        "password": password,
        "name": name?.toJson(),
        "phone": phone,
        "__v": v,
      };
}

class Address {
  Geolocation? geolocation;
  String? city;
  String? street;
  int? number;
  String? zipcode;

  Address({
    this.geolocation,
    this.city,
    this.street,
    this.number,
    this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        geolocation: json["geolocation"] == null
            ? null
            : Geolocation.fromJson(json["geolocation"]),
        city: json["city"],
        street: json["street"],
        number: json["number"],
        zipcode: json["zipcode"],
      );

  Map<String, dynamic> toJson() => {
        "geolocation": geolocation?.toJson(),
        "city": city,
        "street": street,
        "number": number,
        "zipcode": zipcode,
      };
}

class Geolocation {
  String? lat;
  String? long;

  Geolocation({
    this.lat,
    this.long,
  });

  factory Geolocation.fromJson(Map<String, dynamic> json) => Geolocation(
        lat: json["lat"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "long": long,
      };
}

class Name {
  String? firstname;
  String? lastname;

  Name({
    this.firstname,
    this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        firstname: json["firstname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
      };
}
