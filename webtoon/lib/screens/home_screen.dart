import 'package:flutter/material.dart';
import 'package:webtoon/services/api_service.dart';
import 'package:webtoon/widgets/webtoon_sidget.dart';

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
              return Column(
                children: [
                  SizedBox(height: 50,),
                  Expanded(child: makeList(snapshot))
                ],
              );
            }
          return Center(
            child: CircularProgressIndicator(),//로딩창 뜨게 하는거
          );

        },
      ),
    );
  }












  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.separated( //함수의 재활용
             scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),//이미지의 padding
              itemBuilder: (context,index)
              {
                //print(index); //이 함수가 어떻게 움직이는지 이해하고 싶으면 이거 사용
                var webtton = snapshot.data![index];



                return Webtoon(title: webtton.title, thumb: webtton.thumb, id: webtton.id,);
              },
              separatorBuilder: (context,index) => const SizedBox(width: 40,), //인덱스 사이의 구분자를 넣기 위함
            );
  }
}