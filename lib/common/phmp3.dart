import 'package:flutter/material.dart';
import 'package:audioplayer2/audioplayer2.dart';
import 'dart:io';

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
  var _audioPlayerStateSubscription;

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
    audioPlayer.stop();
    setState((){
      playing = false;
    });
    _audioPlayerStateSubscription.cancel();
    super.dispose();
  }

  void play(url) async {
    initAudio();
    try{
      await audioPlayer.play(url);
      setState(() => playing = true);
    }catch(e){
      stop();
    }
  }

  void stop() async {
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
    _audioPlayerStateSubscription = audioPlayer.onPlayerStateChanged.listen((s){
      if(s == AudioPlayerState.COMPLETED){
        stop();
      }
    }, onError: (msg){
      stop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Platform.isIOS ? new Icon(Icons.play_circle_outline,color: widget.color, size: 19.0,) : new Icon(
            playing ? Icons.pause_circle_outline : Icons.play_circle_outline,
            color: widget.color,
            size: 19.0,
          ),
          new Text(' /'+widget.text+'/',style: new TextStyle(fontSize: 18.0,color: widget.color),),
        ],
      ),
      onTap: (){
        if(Platform.isIOS){
          return;
        }
        if(widget.src.isEmpty){
          audioController(widget.src);
        }else{
          audioController(widget.src);
        }
      },
    );
  }
}