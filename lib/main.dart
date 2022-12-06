import 'package:audioplayer/nextscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

void main()
{
  runApp(MaterialApp(home:demo(),));

}
class demo extends StatefulWidget {
  const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
   OnAudioQuery _audioQuery = OnAudioQuery();
   List<SongModel> allsongs =[];


   @override
  void initState() {
      super.initState();
      getallsongs();
  }

  Future<List<SongModel>> getallsongs ()async {
     var status=await Permission.storage.status;
     if(status.isDenied)
       {
         await [Permission.storage].request();
       }
     List<SongModel> allsongs = await _audioQuery.querySongs();
     return allsongs;
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(future: getallsongs(),builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.done)
          {
            List<SongModel>songs=snapshot.data as List<SongModel>;
            return ListView.builder(itemBuilder: (context, index) {
              SongModel s = songs[index];
              return ListTile(onTap: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) {
                  return next(songs,index);
                },));
              },title: Text("${s.title}"),
              subtitle: Text("${s.duration}"),);
            },itemCount: songs.length,);
          }
        else{
          return Center(child: CircularProgressIndicator(),);
        }


      },),
    );
  }
}
