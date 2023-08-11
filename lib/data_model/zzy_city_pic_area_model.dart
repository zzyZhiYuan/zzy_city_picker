class ZzyCityPicAreaModel {
  ZzyCityPicAreaModel({
    required this.areaName,
    required this.areaCode,
  });

  late final String areaName;
  late final String areaCode;

  ZzyCityPicAreaModel.fromJson(Map<String, dynamic> json) {
    areaName = json['areaName'];
    areaCode = json['areaCode'];
  }
}