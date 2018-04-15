import 'package:flutter/material.dart';
import 'package:collins_vocabulary/model/word.dart';
import 'package:collins_vocabulary/common/detail_means.dart';

class Means extends StatefulWidget {
  Word currentItem;
  Means({Key key, this.currentItem}) : super(key:key);
  @override
  MeansState createState() => new MeansState();
}

class MeansState extends State<Means> {
  bool means;

  @override
  void initState() {
    super.initState();
    setState((){
      means = false;
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
      return new DetailMeans(word: widget.currentItem,);
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