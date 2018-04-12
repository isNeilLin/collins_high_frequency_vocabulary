import 'package:flutter/material.dart';
import 'package:collins_vocabulary/model/word.dart';
import 'package:collins_vocabulary/common/phmp3.dart';

class WordDetail extends StatefulWidget {
  Word item;
  WordDetail({this.item});

  @override
  WordDetailState createState() => new WordDetailState();
}

class WordDetailState extends State<WordDetail> {

  Widget _generateWidget(){
    if(widget.item.explain.toString().isNotEmpty){
      final word = widget.item;
      if(widget.item.collins.toString().isNotEmpty){
        return new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: new Text(word.text,style: new TextStyle(fontSize: 22.0,color: Colors.blueGrey),),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new PhMp3(
                      text: word.ph_en,
                      src: word.ph_en_mp3,
                      color: Colors.blueGrey,
                    ),
                    new Text('英音',style: new TextStyle(color: Colors.blueGrey,fontSize: 12.0))
                  ],
                ),
                new Padding(padding: const EdgeInsets.only(left: 24.0)),
                new Column(
                  children: <Widget>[
                    new PhMp3(
                      text: word.ph_am,
                      src: word.ph_am_mp3,
                      color: Colors.blueGrey,
                    ),
                    new Text('美音',style: new TextStyle(color: Colors.blueGrey,fontSize: 12.0),)
                  ],
                )
              ],
            ),
            new Padding(padding: const EdgeInsets.only(top:10.0)),
            new Flexible(
              fit: FlexFit.loose,
              child: new ListView.builder(
                itemBuilder: (BuildContext context, int index){
                  final cn = word.cn_mean[index];
                  return new Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                    child: new Text('${cn['part']} ${cn['means'].join('; ')}',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  );
                },
                itemCount: word.cn_mean.length,
              ),
            ),
            new Padding(padding: const EdgeInsets.only(top:8.0)),
            new Text('柯林斯英英释义',style: new TextStyle(color: Colors.blueGrey),),
            new Padding(padding: const EdgeInsets.only(top:8.0)),
            new Flexible(
              flex: 5,
              fit: FlexFit.loose,
              child: new ListView.builder(
                itemBuilder: (BuildContext context, int index){
                  final en = word.collins[index];
                  return new Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
                      child: new Text('${en['def']}  ${en['tran']}',style: new TextStyle(fontSize: 15.0,color: Colors.black87),)
                  );
                },
                itemCount: word.collins.length,
              ),
            ),
          ],
        );
      }else{
        return new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: new Text(word.text,style: new TextStyle(fontSize: 22.0,color: Colors.blueGrey),),
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Column(
                  children: <Widget>[
                    new PhMp3(
                      text: word.ph_en,
                      src: word.ph_en_mp3,
                      color: Colors.blueGrey,
                    ),
                    new Text('英音',style: new TextStyle(color: Colors.blueGrey,fontSize: 12.0))
                  ],
                ),
                new Padding(padding: const EdgeInsets.only(left: 24.0)),
                new Column(
                  children: <Widget>[
                    new PhMp3(
                      text: word.ph_am,
                      src: word.ph_am_mp3,
                      color: Colors.blueGrey,
                    ),
                    new Text('美音',style: new TextStyle(color: Colors.blueGrey,fontSize: 12.0),)
                  ],
                )
              ],
            ),
            new Padding(padding: const EdgeInsets.only(top:10.0)),
            new Flexible(
              fit: FlexFit.loose,
              child: new ListView.builder(
                itemBuilder: (BuildContext context, int index){
                  final cn = word.cn_mean[index];
                  return new Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                    child: new Text('${cn['part']} ${cn['means'].join('; ')}',
                      style: new TextStyle(fontSize: 14.0),
                    ),
                  );
                },
                itemCount: word.cn_mean.length,
              ),
            ),
            new Padding(padding: const EdgeInsets.only(top:8.0)),
          ],
        );
      }
    }else{
      return new Text(widget.item.explain);
    }
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