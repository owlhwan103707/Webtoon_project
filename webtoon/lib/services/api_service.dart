//API에 요청을 보낼 클래스

import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/models/webtoon_model.dart';

class ApiService{
   static const String baseUrl = "https://webtoon-crawler.nomadcoders.workers.dev";
   static const String today = "today";

   static const String episodes = "episodes"; //개레전드 사건 그냥 이거 없어서 3시간 날려먹음 -> 7월 11일

   static Future<List<WebtoonModel>> getTodaysToons()async{
      //getTodaysToons라는 함수를 불렀을 때 Dart가 제대로 완료될때까지 기다릴길 원한다 -> ApI 요청이 처리돼서 응답을 반활할 때까지 기다리는거
      //이걸 비동기 programming이라고 함

      List<WebtoonModel> webtoonInstances =[]; //Json으로 웹툰을 만들 때 마다 여기 리스트에다가 추가함


      //API에 http요청
      final url = Uri.parse('$baseUrl/$today');
      final response = await http.get(url); //await는 이 부분이 처리될 때 까지 기다리라고 하는것,그리고 async함수 내에서만 사용가능

      if(response.statusCode == 200)
         {
            //print(response.body); 이코드를 JSON으로 디코드 해야함
            final List<dynamic> webtoons = jsonDecode(response.body);

            // for(var webtoon in webtoons)//위에 적은 디코딩 코드가 잘 동작하는지 확인용 -> 잘나옴 7월5일
            //    {
            //       print(webtoon);
            //    }

            for (var webtoon in webtoons)
               {
                   //final toon = WebtoonModel.fromJson(webtoon);
                   //print(toon.title); //긁어온 데이터들을 dart에서 쓸 수 있게 할 수 있는지 확인용 코드
                  final instance = WebtoonModel.fromJson(webtoon);

                  webtoonInstances.add(instance);
               }

            return webtoonInstances;
         }
      throw Error();
   }





   //webtoon_detail_model용 코드
static Future<WebtoonDetailModel> getToonbyId(String id) async {
   final url = Uri.parse("$baseUrl/$id"); //url을 만듬
   final response = await http.get(url); //해당 url로 request를 보냄
   if(response.statusCode == 200) //request가 성공적이라면 response.body를 받아서 json으로 바꿔주기
      {
         final webtoon = jsonDecode(response.body);
         return WebtoonDetailModel.fromjson(webtoon);//받은 json을 WebtoonDetailmodel로 constructor전달
         //전달받은 WebtoonDetailmodel은 각 변수에 맞는 값을 할ㅇ
      }
   throw Error();
}





   static Future<List<WebtoonEpisodeModel>> getLatestEpisodesbyId(String id) async {
      List<WebtoonEpisodeModel> episodesInstances = [];
      final url = Uri.parse("$baseUrl/$id/$episodes"); //url을 만듬
      // Error type _Map<String,dynamic>' is not a subtype of type 'Iterable<dynamic> 이런에러까지 발생함  $episodes요거 없어서
      final response = await http.get(url); //해당 url로 request를 보냄
      if(response.statusCode == 200) //request가 성공적이라면 response.body를 받아서 json으로 바꿔주기
          {
         final episodes = jsonDecode(response.body);

         for(var episode in episodes)
            {
               episodesInstances.add(WebtoonEpisodeModel.fromJson(episode));


            }
         return episodesInstances;
      }
      throw Error();
   }









}