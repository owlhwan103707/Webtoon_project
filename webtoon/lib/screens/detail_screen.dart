import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webtoon/models/webtoon_detail_model.dart';
import 'package:webtoon/models/webtoon_episode_model.dart';
import 'package:webtoon/services/api_service.dart';
//이미지를 클릭시 여기로 보내고 싶음
//그럴러면 어떤 웹툰을 클릭했는지에 대한 정보가 필요함
//그래야 detailscreen이 해당 웹툰의 정보를 보여줄 수 있기 때문
//그러면 Webtton 컴포넌트에서 했던것 처럼 필요한 정보를 넣어줘야함

class DetailScreen extends StatefulWidget
{
  final String title,thumb,id;


  const DetailScreen({
    super.key, required this.title, required this.thumb, required this.id
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  late Future <WebtoonDetailModel> webtoon ; //웹툰 디테일용 퓨처
  late Future <List<WebtoonEpisodeModel>> episodes; //에피소드용 퓨처
  @override
  void initState() {

    super.initState();
    webtoon = ApiService.getToonbyId(widget.id); // 웹툰 디테일용 퓨처
    episodes = ApiService.getLatestEpisodesbyId(widget.id); //에피소드용 퓨처
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(//screen을 위한 기본적인 레이아웃과 설정을 제공함
        backgroundColor: Colors.white,
        appBar: AppBar(

        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green,
        title:  Text("${widget.title}",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),
        ),
      body: Column(
        children: [
          SizedBox(height: 50,),


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
                  child: Image.network(widget.thumb,headers: const{'Referer':'https://comic.naver.com'},),
                ),
              ),
            ],
          ),

        ],
      ),
      );
    }
}
