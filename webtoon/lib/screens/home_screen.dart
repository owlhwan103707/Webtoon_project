import 'package:flutter/material.dart';
import 'package:webtoon/services/api_service.dart';

import '../models/webtoon_model.dart';

class Homescreen extends StatefulWidget{
  const Homescreen ({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebToons() async{ //HTTP 요청을 기다리는 함수
    webtoons = await ApiService.getTodaysToons(); //
    isLoading = false; //값을 false로
    setState(() {//화면 새로고침

    });

  }



  @override
  void initState() {
    super.initState();
    waitForWebToons();//initstate에서 데이터를 받아오는 함수를 호출하고 받아오기가 끝나면 webtoons에 넣는다.
  }

  @override
  Widget build(BuildContext context)
  {
    print(webtoons);
    print(isLoading);
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