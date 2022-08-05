
import 'dart:convert';

GroupModal groupModalFromJson(String str) => GroupModal.fromJson(json.decode(str));

String groupModalToJson(GroupModal data) => json.encode(data.toJson());

class GroupModal {
  GroupModal({
    this.group,

  });

  String? group;


  factory GroupModal.fromJson(Map<String, dynamic> json) => GroupModal(
    group: json["group"],

  );

  Map<String, dynamic> toJson() => {
    "group": group,

  };
}
