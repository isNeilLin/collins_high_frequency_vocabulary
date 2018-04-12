import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';

class PhMp3 extends StatefulWidget {
  final src;
  final text;
  final color;
  PhMp3({this.src,this.text,this.color});
  @override
  PhMp3State createState() => new PhMp3State();
}

class PhMp3State extends State<PhMp3>{
  bool playing = false;
  AudioPlayer audioPlayer = new AudioPlayer();

  @override
  void initState() {
    super.initState();
    audioPlayer.setErrorHandler((msg) {
      print('audioPlayer error : $msg');
    });
  }

  play(url) async {
    final result = await audioPlayer.play(url);
    if (result == 1) setState(() => playing = true);
  }

  pause() async {
    final result = await audioPlayer.pause();
    if (result == 1) setState(() => playing = false);
  }

  void audioController(url){
    if(playing){
      try{
        pause();
      }catch(e){
        print(e);
      }
    }else{
      try{
        play(url);
      }catch(e){
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Icon(
            playing ? Icons.pause_circle_outline : Icons.play_circle_outline,
            color: widget.color,
            size: 19.0,
          ),
          new Text(' /${widget.text}/',style: new TextStyle(fontSize: 18.0,color: widget.color),),
        ],
      ),
      onTap: (){
        if(widget.src.isEmpty){
          audioController(widget.src);
        }else{
          audioController(widget.src);
        }
      },
    );
  }
}