import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/services/api_service.dart';

import '../widgets/episode_widget.dart';
//이미지를 클릭시 여기로 보내고 싶음
//그럴러면 어떤 웹툰을 클릭했는지에 대한 정보가 필요함
//그래야 detailscreen이 해당 웹툰의 정보를 보여줄 수 있기 때문
//그러면 Webtton 컴포넌트에서 했던것 처럼 필요한 정보를 넣어줘야함

class DetailScreen extends StatefulWidget
{
  final String title,thumb,id;


  const DetailScreen({
    super.key, required this.title, required this.thumb, required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  late Future <WebtoonDetailModel> webtoon ; //웹툰 디테일용 퓨처
  late Future <List<WebtoonEpisodeModel>> episodes; //에피소드용 퓨처
  late SharedPreferences prefs; //좋아요 담기용
  bool isLiked = false; //좋아요 관련


  Future initPrefs()async{
    prefs = await SharedPreferences.getInstance();
    final likedToons = prefs.getStringList('likedToons');

    if(likedToons != null) //사용자가 처음 열었을때의 상황 -> 처음열면 likeToons가 없음
      {
        if(likedToons.contains(widget.id)==true)
          {
            setState(() {
              isLiked = true;
            });

          }
      }
    else
      {
        await prefs.setStringList('likedToons', []);
      }
  }

  @override

  void initState() { //이 initState를 사용하기 위해서 기존의 stateless위젯에서 stateful위젯으로 바꿈!!!

    super.initState();
    webtoon = ApiService.getToonbyId(widget.id); // 웹툰 디테일용 퓨처
    episodes = ApiService.getLatestEpisodesbyId(widget.id); //에피소드용 퓨처
    initPrefs();
  }

  onHeartTap()async{ //사용자가 버튼을 누르면
    final likedToons = prefs.getStringList('likedToons'); //List를 가져온다
    if(likedToons != null)
      {
        if(isLiked) //만약 이미 좋아요를 눌렀다면 지우고
          {
            likedToons.remove(widget.id);
          }
        else // 아니라면 추가한다.
          {
            likedToons.add(widget.id);
          }
        await prefs.setStringList('likedToons', likedToons); //그리고 일단 휴대폰 저장소에 추가한다.
        setState(() {
          isLiked = !isLiked;
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(//screen을 위한 기본적인 레이아웃과 설정을 제공함
        backgroundColor: Colors.white,
        appBar: AppBar(

        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        actions: [
          IconButton(onPressed: onHeartTap, //좋아요 함수
            icon: Icon( isLiked ? Icons.favorite : Icons.favorite_border_rounded,),)//부가적인 웹툰 좋아요 기능
        ],
        title:  Text("${widget.title}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),
        ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50,vertical: 50),
          child: Column(

            children: [



              Row(//썸네일 누르면 들어와서 이미지 생성
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  Hero(//Hero위젯은 두 화면 사이의 애니메이션 전환을 쉽게 제공하는 위젯이다.
                    tag: widget.id,
                    child: Container( //이미지의 크기가 커져서 요걸로 수정함
                      width: 250,
                      clipBehavior: Clip.hardEdge, //단순히 borderradius를 쓰면 적용이 안된다. clipbehavior는 자식의 부모 영역 침범을 제어하는것이다.
                      decoration: BoxDecoration( //둥근 효과
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [BoxShadow(blurRadius: 15,offset: Offset(10,10),color: Colors.black.withOpacity(0.5),)] //그림자 효과
                      ),

                      child: Image.network(widget.thumb,headers: const{'Referer':'https://comic.naver.com'},), //상시로 바뀔 수 있는 페이지 확인!!!

                    ),
                  ),

                ],

              ),

              const SizedBox(height: 20,),//칸 띄우기용



              FutureBuilder(future: webtoon, builder: (context,snapshot) //상세 이미지 설명 데이터
                {
                if(snapshot.hasData)
                  {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [


                        Text('${snapshot.data!.genre} / ${snapshot.data!.age}',style: TextStyle(fontSize: 16),),



                        const SizedBox(height: 20,),//칸 띄우기용

                        Text(snapshot.data!.about,style: TextStyle(fontSize: 16),),

                      ],
                    );
                  }
                return Text('로딩중...');
                },
              ),


              const SizedBox(height: 20,),

              //Text('dhwlghks',style: TextStyle(fontSize: 100),), //체크용





          FutureBuilder(future: episodes, builder: (context,snapshot) //상세 이미지 설명 데이터
              {
                if(snapshot.hasData)
                        {
                          return Column(
                            children: [
                              for(var episode in snapshot.data!)
                                Episode(episode: episode,webtoonId:widget.id,)
                            ],
                          );
                        }
                      return Container();
              },
              ),








            ],
          ),
        ),
      ),
    );
  }
}





