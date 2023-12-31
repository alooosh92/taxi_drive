class UserLocation {
  late int? id;
  late double lat;
  late double long;
  late String name;

  UserLocation(
      {required this.lat, required this.long, required this.name, this.id});

  factory UserLocation.frommJson(Map<String, dynamic> json) {
    return UserLocation(
      lat: double.parse(json["late"].toString()),
      long: double.parse(json["long"].toString()),
      name: json["name"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
        "late": lat,
        "long": long,
        "name": name,
      };
}
