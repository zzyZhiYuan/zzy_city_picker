import 'package:zzy_city_picker/data_model/zzy_city_pic_area_model.dart';

class ZzyCityPicCityModel {
  ZzyCityPicCityModel({
    required this.cityName,
    required this.cityCode,
    required this.areas,
  });

  late final String cityName;
  late final String cityCode;
  late final List<ZzyCityPicAreaModel> areas;

  ZzyCityPicCityModel.fromJson(Map<String, dynamic> json) {
    cityName = json['cityName'];
    cityCode = json['cityCode'];
    areas = List.from(json['areas']).map((e) => ZzyCityPicAreaModel.fromJson(e)).toList();
  }
}