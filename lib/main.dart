import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:task_bank_card/consts/theme.dart';
import 'package:task_bank_card/di.dart';
import 'package:task_bank_card/pages/my_cards/my_cards_page.dart';

void main() async{
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cards task',
      darkTheme: CustomTheme.darkThemeData,
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.darkThemeData,
      themeMode: ThemeMode.dark,
      builder: EasyLoading.init(),
      home: MyCardsPage.bloc(),
    );
  }
}