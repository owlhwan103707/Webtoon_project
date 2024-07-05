//api_service에서 받아온 웹툰 정보들을 Dart와 Flutter에서 쓸 수 있는 데이터 형식인 클래스로 바꿔야함
//즉 텍스트를 클래스로 바꿔야함

class WebtoonModel{
  final String title,thumb,id;

//flutter: {id: 777767, title: 역대급 영지 설계사,
// thumb: https://image-comic.pstatic.net/webtoon/777767/thumbnail/thumbnail_IMAG21_cc85f891-272b-450a-b642-cffe1568ab71.jpg}
//위에 보이는 리스트가 내가 받아야할 JSon이다

  WebtoonModel.fromJson(Map<String,dynamic>json) :
      title = json['title'],
      thumb = json['thumb'],
      id = json['id'];
//WebtoonModel title은 Json의 타이틀로 초기화되며 나머지도 똑같다


}