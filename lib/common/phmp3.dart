import 'package:flutter/material.dart';
import 'package:audioplayer/audioplayer.dart';

class PhMp3 extends StatefulWidget {
  final src;
  final text;
  final color;
  final autoplay;
  PhMp3({this.src,this.text,this.color,this.autoplay});
  @override
  PhMp3State createState() => new PhMp3State();
}

class PhMp3State extends State<PhMp3>{
  bool playing = false;
  AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    initAudio();
    if(widget.autoplay){
      play(widget.src);
    }
  }

  @override
  void didUpdateWidget(Widget ph3){
    super.didUpdateWidget(ph3);
    if(widget.autoplay){
      play(widget.src);
    }
  }

  @override
  void dispose(){
    setState((){
      playing = false;
    });
    super.dispose();
  }

  void play(url) async {
    initAudio();
    try{
      final result = await audioPlayer.play(url);
      if (result == 1) setState(() => playing = true);
    }catch(e){
      print(widget.src);
      stop();
    }
  }

  void stop() async {
    print('stop');
    try{
      await audioPlayer.stop();
      setState(() => playing = false);
    }catch(e){
      print(e);
      setState(() => playing = false);
    }
  }

  void audioController(url){
    if(playing){
      stop();
    }else{
      play(url);
    }
  }

  void initAudio(){
    audioPlayer = new AudioPlayer();
    audioPlayer.setErrorHandler((msg) {
      print('audioPlayer error : $msg');
    });
    audioPlayer.setCompletionHandler(() {
      print('complete');
      stop();
    });
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