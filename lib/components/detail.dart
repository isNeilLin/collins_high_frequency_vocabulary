import 'package:flutter/material.dart';
import 'package:collins_vocabulary/model/word.dart';
import 'package:collins_vocabulary/common/detail_means.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Means extends StatefulWidget {
  final Word currentItem;
  final SharedPreferences prefs;

  Means({Key key, this.currentItem,this.prefs}) : super(key:key);
  @override
  MeansState createState() => new MeansState();
}

class MeansState extends State<Means> {
  bool means;
  bool showCn;
  bool showCollins;
  bool showSentence;

  @override
  void initState() {
    super.initState();
    setState((){
      means = false;
      showCn = widget.prefs.getBool('showCn');
      showCollins = widget.prefs.getBool('showcollins');
      showSentence = widget.prefs.getBool('sentence');
    });
  }

  @override
  void didUpdateWidget(Means oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    setState((){
      means = false;
    });
  }

  @override
  void dispose(){
    setState((){
      means = false;
    });
    super.dispose();
  }

  Widget _getMeans(){
    if(means){
      return new DetailMeans(word: widget.currentItem,showCn:showCn,showCollins: showCollins,showSentence: showSentence,);
    }else {
      return new Expanded(child: new Text(''));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
        child: new Column(
          children: <Widget>[
            _getMeans(),
            new InkWell(
              onTap: (){
                setState((){
                  means = !means;
                });
              },
              child: new Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: new Text(
                  means ? '点击隐藏释义' : '点击显示释义',
                  style: new TextStyle(
                      color: Colors.blueGrey
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}