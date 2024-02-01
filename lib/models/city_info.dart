class CityInfo {
  late String city;
  late String currency;
  late double cityCenterLate;
  late double cityCenterLong;
  late int farFromCity;
  late int innerPrice;
  late int plusPrice;
  late int outerPrice;

  CityInfo(
      {required this.city,
      required this.cityCenterLate,
      required this.cityCenterLong,
      required this.currency,
      required this.farFromCity,
      required this.innerPrice,
      required this.outerPrice,
      required this.plusPrice});

  factory CityInfo.fromJson(Map<String, dynamic> json) {
    return CityInfo(
      city: json['city'],
      cityCenterLate: double.parse(json['city_center_late'].toString()),
      cityCenterLong: double.parse(json['city_center_long'].toString()),
      currency: json['currency'].toString(),
      farFromCity: int.parse(json['far_from_city'].toString()),
      innerPrice: int.parse(json['inner_price'].toString()),
      plusPrice: int.parse(json['plus_price'].toString()),
      outerPrice: int.parse(json['outer_price'].toString()),
    );
  }
}
