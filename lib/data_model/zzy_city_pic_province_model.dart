import 'package:zzy_city_picker/data_model/zzy_city_pic_city_model.dart';

class ZzyCityPicProvinceModel {
  ZzyCityPicProvinceModel({
    required this.provinceName,
    required this.provinceCode,
    required this.cities,
  });

  late final String provinceName;
  late final String provinceCode;
  late final List<ZzyCityPicCityModel> cities;

  ZzyCityPicProvinceModel.fromJson(Map<String, dynamic> json) {
    provinceName = json['provinceName'];
    provinceCode = json['provinceCode'];
    cities = List.from(json['cities']).map((e) => ZzyCityPicCityModel.fromJson(e)).toList();
  }
}