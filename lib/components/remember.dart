import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:collins_vocabulary/model/word.dart';
import 'package:collins_vocabulary/common/phmp3.dart';
import 'package:collins_vocabulary/components/means.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:async';
import 'dart:math' as math;
class RememberVocab extends StatefulWidget {
  SharedPreferences prefs;
  RememberVocab({Key key,this.prefs}) : super(key:key);
  @override
  RememberVocabState createState(){
    return new RememberVocabState();
  }
}

class RememberVocabState extends State<RememberVocab> with SingleTickerProviderStateMixin {

  int currentIndex;
  Word currentItem;
  List list = [];
  List studied;
  List stuiedWords;
  int level;
  AnimationController controller;
  Animation<double> animation;
  Tween<double> doubleTween;
  Alignment alignment;

  @override
  initState() {
    super.initState();
    controller = new AnimationController(
        duration: new Duration(milliseconds: 500),
        vsync: this
    );
    doubleTween = new Tween(begin: 0.0,end: -1.8);
    alignment = Alignment.bottomLeft;
    animation = doubleTween.animate(controller)
    ..addStatusListener((status){
      if(status==AnimationStatus.completed){
        setState((){
          alignment = Alignment.bottomRight;
          doubleTween = new Tween(begin: 0.0,end: 1.8);
          animation = doubleTween.animate(controller);
          currentIndex = currentIndex+1 == widget.prefs.getInt('count') ? currentIndex : currentIndex+1;
        });
        controller.reverse();
      }if(status==AnimationStatus.dismissed){
        setState((){
          alignment = Alignment.bottomLeft;
          doubleTween = new Tween(begin: 0.0,end: -1.8);
          animation = doubleTween.animate(controller);
        });
      }
    });

    level = widget.prefs.getInt('level');
    String studiedstr = widget.prefs.getString('studied');
    if(studiedstr.isEmpty){
      studied = [];
    }else{
      studied = json.decode(studiedstr);
    }
    List studiedList = [];
    studied.forEach((item){
      studiedList.add(json.decode(item));
    });
    setState((){
      stuiedWords = studiedList.map((item)=>item['word']).toList();
      currentIndex = 0;
    });
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  Widget _getPhMp3(){
    if(widget.prefs.getBool('en_ph')){
      return new Column(
        children: <Widget>[
          new PhMp3(
              text: currentItem.ph_en,
              src: currentItem.ph_en_mp3,
              color: Colors.blueGrey,
              autoplay: widget.prefs.getBool('autoplay')
          ),
          new Text('英音',style: new TextStyle(color: Colors.blueGrey,fontSize: 12.0))
        ],
      );
    }else {
      return new Column(
        children: <Widget>[
          new PhMp3(
              text: currentItem.ph_am,
              src: currentItem.ph_am_mp3,
              color: Colors.blueGrey,
              autoplay: widget.prefs.getBool('autoplay')
          ),
          new Text('美音',style: new TextStyle(color: Colors.blueGrey,fontSize: 12.0),)
        ],
      );
    }
  }

  Future<List> getlist() async{
    final WholeList = await new Word().getList(level);
    List lastWords = WholeList.where((item){
      return !stuiedWords.contains(item['word']);
    }).toList();
    int count = widget.prefs.getInt('count');
    int len = count > lastWords.length ? lastWords.length : count;
    return lastWords.sublist(0,len);
  }

  _checkIsFinish(BuildContext context,int index,bool know){
    if(index==widget.prefs.getInt('count')){
      final snackBar = new SnackBar(
        content: new Text('已经是最后一个',style: new TextStyle(color: Colors.white),textAlign: TextAlign.center,),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }else{
      if(know){
        studied.add(json.encode(new Word().toJson(currentItem)));
        widget.prefs.setString('studied', json.encode(studied));
      }
      controller.forward();
    }
  }

  Widget _builder(context, snapshot){
    if(snapshot.hasData){
      list = snapshot.data;
      currentItem = new Word().getDetail(list[currentIndex]);
      return new Container(
        color: Colors.blueGrey,
        child: new Column(
          children: <Widget>[
            new Expanded(
              child:new AnimatedBuilder(
                animation: animation,
                builder: (BuildContext context,Widget child){
                  return new Transform(
                    alignment: alignment,
                    transform: new Matrix4.rotationZ(animation.value),
                    child: child,
                  );
                },
                child: new GestureDetector(
                  onHorizontalDragEnd: (DragEndDetails detail){
                    final velocity = detail.primaryVelocity;
                    if(velocity > 0 && velocity.abs() > 5000){
                      _checkIsFinish(context,currentIndex+1,true);
                    }else if(velocity < 0 && velocity.abs() > 5000){
                      _checkIsFinish(context,currentIndex+1,false);
                    }
                  },
                  child: new Container(
                    margin: const EdgeInsets.all(16.0),
                    width: 380.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(8.0),
                      boxShadow: [new BoxShadow(color: Colors.black45,offset: Offset.zero,blurRadius: 5.0,spreadRadius: 0.1)],
                    ),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.only(top: 24.0,bottom:8.0),
                          child: new Text(currentItem.text,style: new TextStyle(fontSize: 28.0,color: Colors.blue),),
                        ),
                        new Expanded(
                            child: new Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                new Container(
                                  child: _getPhMp3(),
                                ),
                                new Padding(padding: const EdgeInsets.only(top:10.0)),
                                new Means(currentItem: currentItem,prefs: widget.prefs),
                              ],
                            )
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            new Expanded(
                                child: new Container(
                                  decoration: new BoxDecoration(
                                    border: new Border(
                                      right: const BorderSide(width: 1.0,color: Colors.grey),
                                      top: const BorderSide(width: 1.0,color: Colors.grey),
                                    ),
                                  ),
                                  child: new Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 10.0),
                                    child: new Center(
                                      child:  new GestureDetector(
                                          onTap: (){
                                            _checkIsFinish(context,currentIndex+1,false);
                                          },
                                          child: new Text('不认识',style: new TextStyle(color: Colors.red,fontSize: 18.0),)
                                      ),
                                    ),
                                  ),
                                )
                            ),
                            /*new Expanded(
                                child: new Container(
                                  decoration: new BoxDecoration(
                                    border: new Border(
                                      right: const BorderSide(width: 1.0,color: Colors.grey),
                                      top: const BorderSide(width: 1.0,color: Colors.grey),
                                    ),
                                  ),
                                  child: new Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 10.0),
                                    child: new Center(
                                      child: new GestureDetector(
                                          onTap: (){
                                            _checkIsFinish(context,currentIndex+1,true);
                                          },
                                          child: new Text('模糊',style: new TextStyle(color: Colors.blue,fontSize: 18.0),)
                                      ),
                                    ),
                                  ),
                                )
                            ),*/
                            new Expanded(
                                child: new Container(
                                  decoration: new BoxDecoration(
                                    border: new Border(
                                      right: const BorderSide(width: 1.0,color: Colors.grey),
                                      top: const BorderSide(width: 1.0,color: Colors.grey),
                                    ),
                                  ),
                                  child: new Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 10.0),
                                    child: new Center(
                                      child: new GestureDetector(
                                          onTap: (){
                                            _checkIsFinish(context,currentIndex+1,true);
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
                  ),
                )
              )
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
    return new Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: new Text('柯林斯高频词汇'),
      ),
      body: new FutureBuilder(
          future: getlist(),
          builder: _builder
      ),
    );
  }
}

