class WebtoonDetailModel
{
  final String title,about,genre,age;
  WebtoonDetailModel.fromjson(Map<String , dynamic>json)

  : title = json['title'],
    about = json['about'],
    genre = json['genre'],
    age = json['age'];

}













// FutureBuilder(future: episodes, builder: (context, snapshot) {
//       if(snapshot.hasData)
//         {
//           return Column(
//             children: [
//               for(var episode in snapshot.data!)
//                 Container(
//                   margin: EdgeInsets.only(bottom: 10),
//                   decoration: BoxDecoration(color: Colors.green.shade400,
//                       borderRadius: BorderRadius.circular(20)),
//
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 40),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(episode.title,style: TextStyle(color: Colors.white,fontSize: 16),),
//                         Icon(Icons.chevron_right_rounded,color: Colors.white,),
//
//                       ],
//                     ),
//                   ),
//                 )
//             ],
//           );
//         }
//       return Container();
//     },
// ),