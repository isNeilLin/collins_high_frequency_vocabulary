import 'package:flutter/material.dart';
import 'package:audioplayer2/audioplayer2.dart';
import 'dart:async';

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
  String lastSrc = '';
  var color;
  AudioPlayer audioPlayer;
  StreamSubscription _audioPlayerStateSubscription;

  @override
  void initState() {
    super.initState();
    initAudio();
  }

  @override
  void dispose(){
    stop();
    _audioPlayerStateSubscription.cancel();
    super.dispose();
  }
  
  @override
  didUpdateWidget(oldWidget){
    if(lastSrc != widget.src && widget.autoplay){
      initAudio();
    }
  }

  Future play(url) async {
    try{
      await audioPlayer.play(url);
      if(mounted){
        setState((){
          lastSrc = url;
          playing = true;
        });
      }
    }catch(e){
      stop();
    }
  }

  Future stop() async {
    try{
      await audioPlayer.stop();
      if(mounted){
        setState(() => playing = false);
      }
    }catch(e){
      if(mounted){
        setState(() => playing = false);
      }
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
    if(widget.autoplay){
      play(widget.src);
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
          new Text(' /'+widget.text+'/',style: new TextStyle(fontSize: 18.0,color: widget.color),),
        ],
      ),
      onTap: (){
        audioPlayer = new AudioPlayer();
        _audioPlayerStateSubscription = audioPlayer.onPlayerStateChanged.listen((s){
          if(s == AudioPlayerState.COMPLETED){
            stop();
          }
        }, onError: (msg){
          stop();
        });
        if(widget.src.isNotEmpty){
          audioController(widget.src);
        }
      },
    );
  }
}