
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/webtoon_episode_model.dart';

class Episode extends StatelessWidget {
  const Episode({
    super.key,
    required this.episode,
    required this.webtoonId,
  });

  final String webtoonId;
  final WebtoonEpisodeModel episode; //episode에 관한 data를 가지고 있는 final field이다.


  onButtontap()async
  {
    await launchUrlString("https://comic.naver.com/webtoon/detail?titleId=$webtoonId&no=${episode.id}");
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(//이 코드가 추가됨으로써 onButtontap()async이 실행 되는것이다.
      onTap: onButtontap,


      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(20)),
      
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(episode.title,style: TextStyle(color: Colors.white,fontSize: 16),),
              Icon(Icons.chevron_right_rounded,color: Colors.white,),
      
            ],
          ),
        ),
      ),
    );
  }
}
