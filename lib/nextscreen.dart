import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query_platform_interface/details/on_audio_query_helper.dart';

class next extends StatefulWidget {
  List<SongModel> songs;
  int index;

  next(this.songs, this.index);

  @override
  State<next> createState() => _nextState();
}

class _nextState extends State<next> {
  final player = AudioPlayer();

  bool play = false;

  double current_time = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    player.onPositionChanged.listen((Duration p) {
      print('Current position: $p');
      setState(() {
        current_time = p.inMilliseconds.toDouble();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text("${widget.songs[widget.index].title}"),
          Slider(
            value: current_time,
            onChanged: (value) async {
              await player.seek(Duration(milliseconds: value.toInt()));
            },
            max: widget.songs[widget.index].duration!.toDouble(),
            min: 0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                  onPressed: () async {

                    if (play) {

                      await player.stop();
                    } else {
                      String path = widget.songs[widget.index].data;
                      await player.play(DeviceFileSource(path));

                    }

                    setState(() async {
                      widget.index--;
                     
                    });
                  },
                  child: Text("<<")),
              ElevatedButton(
                  onPressed: () async {
                    if (play) {

                      await player.pause();
                    } else {
                      String path = widget.songs[widget.index].data;
                      await player.play(DeviceFileSource(path));

                    }
                    play = !play;
                  },
                  child:
                      play ? Icon(Icons.pause) : Icon(Icons.play_arrow_sharp)),
              ElevatedButton(
                  onPressed: () async {

                    if (play) {

                      await player.stop();
                    } else {
                      String path = widget.songs[widget.index].data;
                      await player.play(DeviceFileSource(path));

                    }

                    setState(() async {
                      widget.index++;

                    });
                  },
                  child: Text(">>")),
            ],
          ),
        ],
      ),
    );
  }
}
