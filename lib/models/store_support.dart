class StoreSupport {
  late String subject;
  late String body;

  StoreSupport({
    required this.body,
    required this.subject,
  });

  Map<String, dynamic> toJson() => {
        "body": body,
        "subject": subject,
      };
}
