class TreamModel {
  late int id;
  late String title;
  late String text;
  late bool isPrivacy;

  TreamModel({required this.id, required this.text, required this.title, required this.isPrivacy});

  factory TreamModel.fromJson(Map<String, dynamic> json) {
    return TreamModel(
      id: json["id"],
      text: json["text"],
      isPrivacy: json["isPrivacy"],
      title: json["title"],
    );
  }
}
 