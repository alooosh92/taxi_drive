class ComplaintModel {
  late String subject;
  late String body;

  ComplaintModel({required this.subject, required this.body});

  Map<String, dynamic> toJson() => {"subject": subject, "body": body};
}
