import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key}); //key를 stateless widget이라는 슈퍼클래스로 보냄을 뜻함

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(

      ),
    );
  }
}
