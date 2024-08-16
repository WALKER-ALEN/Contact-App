import 'dart:typed_data';

class ContactModel {
  String name;
  String phoneNumber;
  String email;
  Uint8List? image;
  double? latitude;
  double? longitude;

  ContactModel({
    required this.name,
    required this.phoneNumber,
    required this.email,
    this.image,
    this.latitude,
    this.longitude,
  });
}

