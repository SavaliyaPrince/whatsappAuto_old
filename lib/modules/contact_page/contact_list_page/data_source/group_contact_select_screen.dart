import 'dart:convert';
import 'dart:typed_data';

class groupSelectedModel {
  String? displayName;
  String? mobileNumber;
  Uint8List? avatar;

  groupSelectedModel({
    this.displayName,
    this.mobileNumber,
    this.avatar,
  });

  factory groupSelectedModel.fromJson(Map<String, dynamic> json) {
    return groupSelectedModel(
      displayName: json["displayName"],
      avatar: json["avatar"],
      mobileNumber: json["mobileNumber"],
    );
  }

  static Map<String, dynamic> toMap(
          groupSelectedModel groupSelectedContactModel) =>
      {
        "displayName": groupSelectedContactModel.displayName,
        "avatar": groupSelectedContactModel.avatar,
        "mobileNumber": groupSelectedContactModel.mobileNumber,
      };

  static String encode(List<groupSelectedModel> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>(
                (music) => groupSelectedModel.toMap(music))
            .toList(),
      );

  static List<groupSelectedModel> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<groupSelectedModel>((item) => groupSelectedModel.fromJson(item))
          .toList();
}
