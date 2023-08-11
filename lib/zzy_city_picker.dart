import 'package:flutter/material.dart';
import 'package:zzy_city_picker/data_model/zzy_city_pic_result_model.dart';
import 'package:zzy_city_picker/data_model/zzy_city_picker_type.dart';
import 'package:zzy_city_picker/zzy_city_picker_pca.dart';

typedef ZzyCityPickerCallBack = Function(ZzyCityPicResultModel? result);

class ZzyCityPicker {
  static Future<ZzyCityPicResultModel?> showPicker(
    BuildContext context, {
    ZzyCityPickerType type = ZzyCityPickerType.pca,
    Widget? title,
    String? cancelText,
    TextStyle? cancelTextStyle,
    String? confirmText,
    TextStyle? confirmTextStyle,
    double? sheetHeight,
    ZzyCityPicResultModel? currentResult,
  }) async {
    ZzyCityPicResultModel? result = await showModalBottomSheet<ZzyCityPicResultModel?>(
      useSafeArea: true,
      context: context,
      builder: (context) {
        return ZzyCityPickerPCA(
          title: title,
          cancelText: cancelText,
          cancelTextStyle: cancelTextStyle,
          confirmText: confirmText,
          confirmTextStyle: confirmTextStyle,
          sheetHeight: sheetHeight,
          currentResult: currentResult,
          type: type,
          callBack: (result) {
            Navigator.pop(context, result);
          },
        );
      },
    );
    return result;
  }
}
