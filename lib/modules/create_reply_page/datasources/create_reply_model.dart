import 'dart:convert';

CreateReplyModel createReplyModelFromJson(String str) => CreateReplyModel.fromJson(json.decode(str));

String createReplyModelToJson(CreateReplyModel data) => json.encode(data.toJson());

class CreateReplyModel {
  CreateReplyModel({
    this.inComingKeyword,
    this.replyMassage,
    this.time,
  });

  String? inComingKeyword;
  String? replyMassage;
  DateTime? time;

  factory CreateReplyModel.fromJson(Map<String, dynamic> json) => CreateReplyModel(
        inComingKeyword: json["inComingKeyword"],
        replyMassage: json["replyMassage"],
        time: DateTime.parse(json["time"]),
      );

  Map<String, dynamic> toJson() => {
        "inComingKeyword": inComingKeyword,
        "replyMassage": replyMassage,
        "time": time!.toIso8601String(),
      };
}
