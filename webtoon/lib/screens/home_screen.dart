import 'package:flutter/material.dart';
import 'package:webtoon/services/api_service.dart';

import '../models/webtoon_model.dart';

class Homescreen extends StatelessWidget{
  Homescreen ({super.key});

  Future <List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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


      body: FutureBuilder(
        future: webtoons,
        builder: (context, snapshot){
          if(snapshot.hasData)
            {
              return const Text("There is data");
            }
          return const Text("로딩");
        },
      ),
    );
  }
}