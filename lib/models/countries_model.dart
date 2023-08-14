// country_model.dart
class CountryModel {
  List<Country> countries;
  String message;
  String statusCode;

  CountryModel({required this.countries, required this.message, required this.statusCode});

  factory CountryModel.fromJson(Map<String, dynamic> json) {
    var countryList = json['countries'] as List;
    List<Country> countries =
    countryList.map((countryJson) => Country.fromJson(countryJson)).toList();

    return CountryModel(
      countries: countries,
      message: json['message'],
      statusCode: json['status_code'],
    );
  }
}

class Country {
  int id;
  String name;
  String code;
  int mobileCode;

  Country({required this.id, required this.name, required this.code, required this.mobileCode});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      mobileCode: json['mobile_code'],
    );
  }
}
