import 'package:flutter/material.dart';
import 'package:collins_vocabulary/model/word.dart';
import 'package:collins_vocabulary/common/phmp3.dart';
import 'package:collins_vocabulary/common/detail_means.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordDetail extends StatefulWidget {
  final Word item;
  final SharedPreferences prefs;
  WordDetail({Key key,this.item,this.prefs}) : super(key:key);

  @override
  WordDetailState createState() => new WordDetailState();
}

class WordDetailState extends State<WordDetail> {
  bool showCn;
  bool showCollins;
  bool showSentence;

  @override
  initState(){
    super.initState();
    showCn = widget.prefs.getBool('showCn');
    showCollins = widget.prefs.getBool('showcollins');
    showSentence = widget.prefs.getBool('sentence');
  }

  Widget _getPhMp3(){
    if(widget.prefs.getBool('en_ph')){
      if(widget.item.ph_en_mp3.toString().isEmpty){
        return new Text('无法获取发音');
      }
      return new Column(
        children: <Widget>[
          new PhMp3(
              text: widget.item.ph_en,
              src: widget.item.ph_en_mp3,
              color: Colors.blueGrey,
              autoplay: false
          ),
          new Text('英音',style: new TextStyle(color: Colors.blueGrey,fontSize: 12.0))
        ],
      );
    }else {
      if(widget.item.ph_am_mp3.toString().isEmpty){
        return new Text('无法获取发音');
      }
      return new Column(
        children: <Widget>[
          new PhMp3(
              text: widget.item.ph_am,
              src: widget.item.ph_am_mp3,
              color: Colors.blueGrey,
              autoplay: false
          ),
          new Text('美音',style: new TextStyle(color: Colors.blueGrey,fontSize: 12.0),)
        ],
      );
    }
  }

  Widget _generateWidget(){
    final word = widget.item;
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: new Text(word.text,style: new TextStyle(fontSize: 22.0,color: Colors.blueGrey),),
        ),
        _getPhMp3(),
        new Padding(padding: const EdgeInsets.only(top:10.0)),
        new DetailMeans(word: word,showCn:showCn,showCollins:showCollins,showSentence:showSentence)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.item.text),
        elevation: 0.0,
      ),
      body: _generateWidget(),
    );
  }
}