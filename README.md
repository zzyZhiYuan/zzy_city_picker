# zzy_city_picker

## 简介

这是一个，中国大陆用户使用的城市选择器，提供三种选择方式，选择省份，选择省市，选择省市区


## 摘要

```dart

final result = await ZzyCityPicker.showPicker(context, currentResult: selected, type: ZzyCityPickerType.p);
if (result != null) {
    setState(() {
      selected = result;
    });
}


```


## 用法

```dart
//选择省
ZzyCityPicker.showPicker(context, currentResult: selected, type: ZzyCityPickerType.p);

//选择省市
ZzyCityPicker.showPicker(context, currentResult: selected, type: ZzyCityPickerType.pc);


//选择省市区（type 默认值为 ZzyCityPickerType.pca，所以选择省市区的时候，可以传type）
ZzyCityPicker.showPicker(context, currentResult: selected);

```
