import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webtoon/screens/detail_screen.dart';

//컴포넌트,위젯 분리를 위한 클래스

class Webtoon extends StatelessWidget
{

  final String title,thumb,id;


  const Webtoon({
    super.key, required this.title, required this.thumb, required this.id
  });

  @override
  Widget build(BuildContext context) {


    return GestureDetector(//대부분의 동작을 감지하는 위젯 GestureDetector
      onTap: ()
      {
        //print('take me home');  //확인용


        Navigator.push(context, MaterialPageRoute(builder:  //Navigator.push를 이용해 StatelessWidget을 스크린처럼 보이게 만들고 있다.
            (context)=> DetailScreen(title: title, thumb: thumb, id: id),
          fullscreenDialog: true,//이미지가 바닥에서 튀어나오는듯한 에니메이션 효과 추가
        ),
        );//route는 다른 위젯과는 다르게 StatelessWidget을 애니메이션 효과로 감싸서 스크린처럼 보이기 위해 사용한다.


      },//버튼 Tap시 발생하는 event
      child: Column(
        children: [
      
          Container( //이미지의 크기가 커져서 요걸로 수정함
            width: 250,
            clipBehavior: Clip.hardEdge, //단순히 borderradius를 쓰면 적용이 안된다. clipbehavior는 자식의 부모 영역 침범을 제어하는것이다.
            decoration: BoxDecoration( //둥근 효과
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(blurRadius: 15,offset: Offset(10,10),color: Colors.black.withOpacity(0.5),)] //그림자 효과
            ),
            child: Image.network(thumb,headers: const{'Referer':'https://comic.naver.com'},),
          ),

      
          SizedBox(height: 10,),
          Text(title,style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
        ],
      ),
    );
  }
}