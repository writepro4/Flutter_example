import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/constants/material_white.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      //전체적인 테마 색상 적용 할려면 여기다 ThemeData 선언해야됨
      theme: ThemeData(primarySwatch: white),
    );
  }
}
