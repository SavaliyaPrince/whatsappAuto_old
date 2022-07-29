import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';

ContactModel contactModelFromJson(String str) =>
    ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

class ContactModel {
  ContactModel({
    this.displayName,
    this.avatar,
    this.mobileNumber,
    this.isCheck,
    this.image,
  });

  String? displayName;
  Uint8List? avatar;
  String? mobileNumber;
  String? image;
  RxBool? isCheck = false.obs;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        displayName: json["displayName"],
        avatar: json["avatar"],
        image: json["image"],
        mobileNumber: json["mobileNumber"],
        isCheck: false.obs,
      );

  Map<String, dynamic> toJson() => {
        "displayName": displayName,
        "avatar": avatar,
        "image": base64.decode(image!),
        "mobileNumber": mobileNumber,
        "isCheck": isCheck,
      };
}
