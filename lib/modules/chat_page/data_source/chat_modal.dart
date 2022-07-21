import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    this.message,
    this.istype,
    this.time,
  });

  String? message;
  String? istype;
  DateTime? time;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        message: json["message"],
        istype: json["istype"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "istype": istype,
        "time": time?.toIso8601String(),
      };
}
