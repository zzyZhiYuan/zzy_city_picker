import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:zzy_city_picker/data_model/zzy_city_pic_province_model.dart';
import 'package:zzy_city_picker/data_model/zzy_city_pic_result_model.dart';
import 'package:zzy_city_picker/data_model/zzy_city_picker_data.dart';
import 'package:zzy_city_picker/data_model/zzy_city_picker_type.dart';
import 'package:zzy_city_picker/zzy_city_picker.dart';

class ZzyCityPickerPCA extends StatefulWidget {
  final Widget? title;
  final String? cancelText;
  final TextStyle? cancelTextStyle;
  final String? confirmText;
  final TextStyle? confirmTextStyle;
  final ZzyCityPickerCallBack callBack;
  final double? sheetHeight;
  final ZzyCityPicResultModel? currentResult;
  final ZzyCityPickerType type;

  const ZzyCityPickerPCA({Key? key, this.title, this.cancelText, this.cancelTextStyle, this.confirmText, this.confirmTextStyle, required this.callBack, this.sheetHeight, this.currentResult, required this.type}) : super(key: key);

  @override
  State<ZzyCityPickerPCA> createState() => _ZzyCityPickerPCAState();
}

class _ZzyCityPickerPCAState extends State<ZzyCityPickerPCA> {
  // 省市区数据
  late List<ZzyCityPicProvinceModel> pcaData;
  late FixedExtentScrollController provinceScrollController;
  late FixedExtentScrollController cityScrollController;
  late FixedExtentScrollController areaScrollController;
  int provinceIdx = 0;
  int cityIdx = 0;
  int areaIdx = 0;

  void _initData() {
    pcaData = [...List.generate(zzyCityPickerData.length, (index) => ZzyCityPicProvinceModel.fromJson(zzyCityPickerData[index]))];


    if (widget.currentResult != null) {
      provinceIdx = _findIndexByCode(pcaData, widget.currentResult!.provinceCode, (item) => item.provinceCode);
      cityIdx = widget.currentResult!.provinceCode != null ? _findIndexByCode(pcaData[provinceIdx].cities, widget.currentResult!.cityCode, (item) => item.cityCode) : 0;
      areaIdx = widget.currentResult!.cityCode != null ? _findIndexByCode(pcaData[provinceIdx].cities[cityIdx].areas, widget.currentResult!.areaCode, (item) => item.areaCode) : 0;
    }
    provinceScrollController = FixedExtentScrollController(initialItem: provinceIdx);
    cityScrollController = FixedExtentScrollController(initialItem: cityIdx);
    areaScrollController = FixedExtentScrollController(initialItem: areaIdx);

  }
  int _findIndexByCode<T>(List<T> list, String? code, String Function(T) getCode) {
    if (code != null) {
      final index = list.indexWhere((item) => getCode(item) == code);
      if(index!=-1){
        return index;
      }
    }
    return 0;
  }

  @override
  void initState() {
    _initData();
    super.initState();
  }

  ///处理返回的数据
  ZzyCityPicResultModel _getResult() {
    String? pName = pcaData[provinceIdx].provinceName;
    String? pCode = pcaData[provinceIdx].provinceCode;

    String? cName = pcaData[provinceIdx].cities.isNotEmpty ? pcaData[provinceIdx].cities[cityIdx].cityName : null;
    String? cCode = pcaData[provinceIdx].cities.isNotEmpty ? pcaData[provinceIdx].cities[cityIdx].cityCode : null;

    String? aName = pcaData[provinceIdx].cities.isNotEmpty && pcaData[provinceIdx].cities[cityIdx].areas.isNotEmpty ? pcaData[provinceIdx].cities[cityIdx].areas[areaIdx].areaName : null;
    String? aCode = pcaData[provinceIdx].cities.isNotEmpty && pcaData[provinceIdx].cities[cityIdx].areas.isNotEmpty ? pcaData[provinceIdx].cities[cityIdx].areas[areaIdx].areaCode : null;

    return ZzyCityPicResultModel(provinceName: pName, provinceCode: pCode, cityName: cName, cityCode: cCode, areaName: aName, areaCode: aCode);
  }

  ///改变省份
  void _changeProvince(int index) {
    setState(() {
      provinceIdx = index;
      cityIdx = 0;
      cityScrollController.jumpToItem(cityIdx);
      areaIdx = 0;
      areaScrollController.jumpToItem(areaIdx);
    });
  }

  ///改变城市
  void _changeCity(int index) {
    setState(() {
      cityIdx = index;
      areaIdx = 0;
      areaScrollController.jumpToItem(areaIdx);
    });
  }

  ///改变地区
  void _changeArea(int index) {
    areaIdx = index;
  }



  @override
  Widget build(BuildContext context) {
    return Material(
      child: SizedBox(
        height: widget.sheetHeight ?? 280,
        child: Column(
          children: [
            Container(
              height: 40,
              color: Colors.grey[100],
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      widget.callBack(null);
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        widget.cancelText??"取消",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:widget.cancelTextStyle?? const TextStyle(
                          fontSize: 14,
                          color:Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: widget.title??const SizedBox(),
                  ),
                  InkWell(
                    onTap: (){
                      ZzyCityPicResultModel result=_getResult();
                      widget.callBack(result);
                    },
                    child: Container(
                      width: 80,
                      height: 40,
                      alignment: Alignment.center,
                      child: Text(
                        widget.confirmText??"确定",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:widget.cancelTextStyle?? const TextStyle(
                          fontSize: 14,
                          color:Colors.blue,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: buildBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget buildBody(){

    if(widget.type==ZzyCityPickerType.p){
      return Row(
        children: [
          buildBodyProvinceItem(),
        ],
      );
    }else if(widget.type==ZzyCityPickerType.pc){
      return Row(
        children: [
          buildBodyProvinceItem(),
          buildBodyCityItem(),
        ],
      );
    }else{
      return Row(
        children: [
          buildBodyProvinceItem(),
          buildBodyCityItem(),
          buildBodyAreaItem(),
        ],
      );
    }

  }

  Widget buildBodyProvinceItem(){
    return Expanded(
      child: Center(
        child: CupertinoPicker(
          itemExtent: 32.0,
          scrollController: provinceScrollController,
          selectionOverlay: Container(color: Colors.grey.withOpacity(0.1)),
          onSelectedItemChanged: (int index) {
            _changeProvince(index);
          },
          children: List.generate(
            pcaData.length,
                (index) {
              return Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: FittedBox(
                  child: Text(
                    pcaData[index].provinceName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildBodyCityItem(){
    return Expanded(
      child: Center(
        child: CupertinoPicker(
          itemExtent: 32.0,
          scrollController: cityScrollController,
          selectionOverlay: Container(color: Colors.grey.withOpacity(0.1)),
          onSelectedItemChanged: (int index) {
            _changeCity(index);
          },
          children: List.generate(
            pcaData[provinceIdx].cities.length,
                (index) {
              return Container(
                padding: const EdgeInsets.only(left: 5, right: 5),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Text(
                    pcaData[provinceIdx].cities[index].cityName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildBodyAreaItem(){
    return Expanded(
        child: Center(
          child: CupertinoPicker(
              itemExtent: 32.0,
              scrollController: areaScrollController,
              selectionOverlay: Container(color: Colors.grey.withOpacity(0.1)),
              onSelectedItemChanged: (int index) {
                _changeArea(index);
              },
              children: List.generate(pcaData[provinceIdx].cities.isNotEmpty ? pcaData[provinceIdx].cities[cityIdx].areas.length : 0, (index) {
                return Container(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  alignment: Alignment.center,
                  child: FittedBox(
                    child: Text(
                      pcaData[provinceIdx].cities[cityIdx].areas[index].areaName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                );
              })),
        ));
  }


}
