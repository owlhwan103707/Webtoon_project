import 'package:flutter/material.dart';
import 'package:webtoon/services/api_service.dart';

import '../models/webtoon_model.dart';

class Homescreen extends StatelessWidget{
  Homescreen ({super.key});

  final Future <List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

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
              return ListView.separated( //함수의 재활용
               scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (context,index)
                {
                  print(index); //이 함수가 어떻게 움직이는지 이해하고 싶으면 이거 사용
                  var webtton = snapshot.data![index];
                  return Text(webtton.title);
                },
                separatorBuilder: (context,index) => const SizedBox(width: 20,),
              );
            }
          return Center(
            child: CircularProgressIndicator(),//로딩창 뜨게 하는거
          );

        },
      ),
    );
  }
}