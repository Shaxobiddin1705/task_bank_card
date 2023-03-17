import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:task_bank_card/consts/colors.dart';
import 'package:task_bank_card/services/dio/dio_service.dart';
import 'package:task_bank_card/services/sql/sql_database.dart';

final GetIt di = GetIt.I;
var sql = di.get<SqlService>();
var dio = di.get<DioService>();

Widget home = const Scaffold();

Future<void> setup() async {
  await _setupConfigs();
  await _setupFactories();
}

Future _setupConfigs() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLoading.instance
    ..displayDuration = const Duration(seconds: 2)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = MyColors.primaryWhite
    ..backgroundColor = MyColors.darkBlue
    ..indicatorColor = MyColors.primaryWhite
    ..textColor = MyColors.primaryWhite
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = true
    ..animationStyle = EasyLoadingAnimationStyle.offset
    ..successWidget;
}

Future _setupFactories() async {
  di.registerFactory(() => SqlService());
  di.registerFactory(() => DioService());
}