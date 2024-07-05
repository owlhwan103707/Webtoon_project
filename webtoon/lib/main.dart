
import 'package:flutter/material.dart';
import 'package:webtoon/screens/home_screen.dart';
import 'package:webtoon/services/api_service.dart';


void main() {
  ApiService().getTodaysToons();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key}); //key를 stateless widget이라는 슈퍼클래스로 보냄을 뜻함

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homescreen(),//home_screen.dart와 연결
    );
  }
}
