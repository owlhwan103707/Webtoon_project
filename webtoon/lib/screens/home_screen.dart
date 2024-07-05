import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget{
  const Homescreen ({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(//screen을 위한 기본적인 레이아웃과 설정을 제공함
      backgroundColor: Colors.white,
      appBar: AppBar(

        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title: const Text("오늘의 웹툰",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),
      ),

    );
  }

}