import 'package:flutter/material.dart';
import 'package:collins_vocabulary/model/word.dart';
import 'package:collins_vocabulary/common/phmp3.dart';


class RememberVocab extends StatefulWidget {
  int level;
  Map<String,bool> options;
  RememberVocab({this.level,this.options});
  @override
  RememberVocabState createState(){
    return new RememberVocabState(level: level,options: options);
  }
}

class RememberVocabState extends State<RememberVocab> {
  int level;
  int currentIndex = 0;
  Word currentItem;
  List list = [];
  Map<String,bool> options;
  RememberVocabState({this.level,this.options});

  Widget _builder(context, snapshot){
    if(snapshot.hasData){
      list = snapshot.data;
      currentItem = new Word().getDetail(list[currentIndex]);
      return new Container(
        child: new Column(
          children: <Widget>[
            new Expanded(
                child: new Container(
                  margin: const EdgeInsets.all(16.0),
                  width: 360.0,
                  decoration: new BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: new BorderRadius.circular(8.0),
                    boxShadow: [new BoxShadow(color: Colors.black54,offset: Offset.zero,blurRadius: 5.0,spreadRadius: 0.1)],
                  ),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                        padding: const EdgeInsets.only(top: 24.0,bottom:8.0),
                        child: new Text(currentItem.text,style: new TextStyle(fontSize: 28.0,color: Colors.yellowAccent),),
                      ),
                      new Expanded(
                          child: new Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Container(
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    new Column(
                                      children: <Widget>[
                                        new PhMp3(
                                          text: currentItem.ph_en,
                                          src: currentItem.ph_en_mp3,
                                          color: Colors.white,
                                        ),
                                        new Text('英音',style: new TextStyle(color: Colors.white70,fontSize: 12.0))
                                      ],
                                    ),
                                    new Padding(padding: const EdgeInsets.only(left: 24.0)),
                                    new Column(
                                      children: <Widget>[
                                        new PhMp3(
                                          text: currentItem.ph_am,
                                          src: currentItem.ph_am_mp3,
                                          color: Colors.white,
                                        ),
                                        new Text('美音',style: new TextStyle(color: Colors.white70,fontSize: 12.0),)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              new Padding(padding: const EdgeInsets.only(top:10.0)),
                              new Flexible(
                                fit: FlexFit.loose,
                                child: new ListView.builder(
                                  itemBuilder: (BuildContext context, int index){
                                    final cn = currentItem.cn_mean[index];
                                    return new Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24.0,vertical: 2.0),
                                      child: new Text('${cn['part']} ${cn['means'].join('; ')}',
                                        style: new TextStyle(fontSize: 14.0,color: Colors.white),
                                      ),
                                    );
                                  },
                                  itemCount: currentItem.cn_mean.length,
                                ),
                              ),
                            ],
                          )
                      )
                    ],
                  ),
                )
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                new Expanded(
                    child: new Container(
                      decoration: new BoxDecoration(border: new Border(
                        right: const BorderSide(width: 1.0,color: Colors.grey),
                        top: const BorderSide(width: 1.0,color: Colors.grey),
                      )),
                      child: new Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: new Center(
                        child:  new GestureDetector(
                            onTap: (){
                              setState((){
                                currentIndex = currentIndex+1;
                                currentItem = new Word().getDetail(list[currentIndex]);
                              });
                            },
                            child: new Text('不认识',style: new TextStyle(color: Colors.red,fontSize: 18.0),)
                        ),
                      ),
                      ),
                    )
                ),
                new Expanded(
                    child: new Container(
                      decoration: new BoxDecoration(border: new Border(
                        right: const BorderSide(width: 1.0,color: Colors.grey),
                        top: const BorderSide(width: 1.0,color: Colors.grey),
                      )),
                      child: new Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: new Center(
                        child: new GestureDetector(
                            onTap: (){
                              setState((){
                                currentIndex = currentIndex+1;
                                currentItem = new Word().getDetail(list[currentIndex]);
                              });
                            },
                            child: new Text('模糊',style: new TextStyle(color: Colors.blue,fontSize: 18.0),)
                        ),
                      ),
                      ),
                    )
                ),
                new Expanded(
                    child: new Container(
                      decoration: new BoxDecoration(border: new Border(
                        top: const BorderSide(width: 1.0,color: Colors.grey),
                      )),
                      child: new Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: new Center(
                          child: new GestureDetector(
                              onTap: (){
                                setState((){
                                  currentIndex = currentIndex+1;
                                  currentItem = new Word().getDetail(list[currentIndex]);
                                });
                              },
                              child: new Text('认识',style: new TextStyle(color: Colors.green,fontSize: 18.0),)
                          ),
                        ),
                      ),
                    )
                ),
              ],
            ),
          ],
        ),
      );
    }
    return new Center(
      child: new CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new FutureBuilder(
        future: new Word().getList(level),
        builder: _builder
    );
  }
}
