class CityInfo {
  late String city;
  late String currency;
  late double cityCenterLate;
  late double cityCenterLong;
  late double farFromCity;
  late double innerPrice;
  late double plusPrice;
  late double outerPrice;
  late double lessPrice;

  CityInfo(
      {required this.city,
      required this.cityCenterLate,
      required this.cityCenterLong,
      required this.currency,
      required this.farFromCity,
      required this.innerPrice,
      required this.outerPrice,
      required this.plusPrice,
      required this.lessPrice});

  factory CityInfo.fromJson(Map<String, dynamic> json) {
    return CityInfo(
      city: json['city'],
      cityCenterLate: double.parse(json['city_center_late'].toString()),
      cityCenterLong: double.parse(json['city_center_long'].toString()),
      currency: json['currency'].toString(),
      farFromCity: double.parse(json['far_from_city'].toString()),
      innerPrice: double.parse(json['inner_price'].toString()),
      plusPrice: double.parse(json['plus_price'].toString()),
      outerPrice: double.parse(json['outer_price'].toString()),
      lessPrice: double.parse(json['less_price'].toString()),
    );
  }
}
