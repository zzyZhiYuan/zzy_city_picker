import 'package:flutter/material.dart';
import 'package:zzy_city_picker/data_model/zzy_city_pic_result_model.dart';
import 'package:zzy_city_picker/data_model/zzy_city_picker_type.dart';
import 'package:zzy_city_picker/zzy_city_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ZzyCityPicResultModel? selectedP;
  ZzyCityPicResultModel? selectedPC;
  ZzyCityPicResultModel? selectedPCA;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('zzyCityPicker example'),
        ),
        body: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                children: [
                  //选择省
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 100,
                          child: Center(
                            child: Text("选择省"),
                          ),
                        ),
                        Expanded(
                          flex: 300,
                          child: GestureDetector(
                            onTap: () async {
                              final result = await ZzyCityPicker.showPicker(context, currentResult: selectedP, type: ZzyCityPickerType.p);
                              if (result != null) {
                                setState(() {
                                  selectedP = result;
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black26,
                                ),
                              ),
                              child: Text(selectedP != null ? "${selectedP!.provinceName}" : "请选择"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //选择省市
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 100,
                          child: Center(
                            child: Text("选择省市"),
                          ),
                        ),
                        Expanded(
                          flex: 300,
                          child: GestureDetector(
                            onTap: () async {
                              final result = await ZzyCityPicker.showPicker(context, currentResult: selectedPC, type: ZzyCityPickerType.pc);
                              if (result != null) {
                                setState(() {
                                  selectedPC = result;
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black26,
                                ),
                              ),
                              child: Text(selectedPC != null ? "${selectedPC!.provinceName}-${selectedPC!.cityName}" : "请选择"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //选择省市区
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 100,
                          child: Center(
                            child: Text("选择省市区"),
                          ),
                        ),
                        Expanded(
                          flex: 300,
                          child: GestureDetector(
                            onTap: () async {
                              final result = await ZzyCityPicker.showPicker(context, currentResult: selectedPCA);
                              if (result != null) {
                                setState(() {
                                  selectedPCA = result;
                                });
                              }
                            },
                            child: Container(
                              height: 40,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black26,
                                ),
                              ),
                              child: Text(selectedPCA != null ? "${selectedPCA!.provinceName}-${selectedPCA!.cityName}-${selectedPCA!.areaName}" : "请选择"),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
