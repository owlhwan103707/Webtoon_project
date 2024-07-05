import 'dart:developer';

import 'package:http/http.dart' as http;

class ApiService{
   final String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
   final String today = "today";

   void getTodaysToons()async{
      //getTodaysToons라는 함수를 불렀을 때 Dart가 제대로 완료될때까지 기다릴길 원한다 -> ApI 요청이 처리돼서 응답을 반활할 때까지 기다리는거
      //이걸 비동기 programming이라고 함
      final url = Uri.parse('$baseUrl/$today');
      final response = await http.get(url); //await는 이 부분이 처리될 때 까지 기다리라고 하는것,그리고 async함수 내에서만 사용가능

      if(response.statusCode == 200)
         {
            print(response.body);
            return;
         }
      throw Error();
   }


}