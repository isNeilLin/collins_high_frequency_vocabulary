import 'package:flutter/material.dart';
import 'package:collins_vocabulary/components/selectBook.dart';

class Mine extends StatefulWidget {
  @override
  MineState createState() => new MineState();
}

class MineState extends State<Mine> {
  bool showColins;
  bool AutoSound;
  bool Sentence;
  bool showCn;
  @override
  void initState() {
    super.initState();
    showColins = true;
    AutoSound = true;
    Sentence = true;
    showCn = true;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.cover,
                    image: new AssetImage('assets/img/mine.jpeg'),
                )
            ),
            padding: const EdgeInsets.symmetric(vertical: 42.0,horizontal: 16.0),
            child: new Row(
              children: <Widget>[
                new Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.circular(6.0),
                      image: new DecorationImage(
                        fit: BoxFit.cover,
                        image: new AssetImage('assets/img/account.jpeg'),
                      )
                  ),
                ),
                new Padding(padding: const EdgeInsets.only(left: 12.0)),
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text('Neil',style: new TextStyle(fontSize: 26.0,color: Colors.amberAccent),),
                    new Text('已连续学习30天',style: new TextStyle(fontSize: 14.0,color: Colors.white70),),
                  ],
                )
              ],
            ),
          ),
          new InkWell(
            onTap: (){
              Navigator.of(context).push(
                new MaterialPageRoute(
                  builder: (context) => new SelectBook()
                )
              );
            },
            child: new Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new Text('切换单词书',style: new TextStyle(fontSize: 16.0),),
                  new Icon(Icons.chevron_right,size: 30.0,color: Colors.grey)
                ],
              )
            ),
          ),
          new SwitchListTile(
              title: new Text('自动播放发音'),
              value: AutoSound,
              onChanged: (bool value) {
                setState((){
                  AutoSound = value;
                });
              }
          ),
          new SwitchListTile(
              title: new Text('开启柯林斯词典'),
              value: showColins,
              onChanged: (bool value) {
                setState((){
                  showColins = value;
                });
              }
          ),
          new SwitchListTile(
              title: new Text('显示翻译'),
              value: showCn,
              onChanged: (bool value) {
                setState((){
                  showCn = value;
                });
              }
          ),
          new SwitchListTile(
              title: new Text('显示例句'),
              value: Sentence,
              onChanged: (bool value) {
                setState((){
                  Sentence = value;
                });
              }
          ),
        ],
      ),
    );
  }
}