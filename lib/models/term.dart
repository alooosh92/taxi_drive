class TreamModel {
  late int id;
  late String title;
  late String text;

  TreamModel({required this.id, required this.text, required this.title});

  factory TreamModel.fromJson(Map<String, dynamic> json) {
    return TreamModel(
      id: json["policy_id"],
      text: json["text"],
      title: json["title"],
    );
  }
}
