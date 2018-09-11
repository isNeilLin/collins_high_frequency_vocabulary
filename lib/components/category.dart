import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collins_vocabulary/components/word_list.dart';

class WordList extends StatefulWidget {
  SharedPreferences prefs;
  WordList({Key key,this.prefs}) : super(key:key);

  @override
  State<StatefulWidget> createState(){
    return WordListState();
  }
}

class WordListState extends State<WordList> {
  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: new Text('分类列表'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.blueGrey,
        child: new Row(
          children: <Widget>[
            new Expanded(
              key: Key('value1'),
              child: new Container(
              child: new Column(
                children: <Widget>[
                  new Expanded(
                    key: Key('value2'),
                    child:new Container(
                    margin: const EdgeInsets.only(right: 10.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(8.0),
                      boxShadow: [new BoxShadow(color: Colors.black45,offset: Offset.zero,blurRadius: 5.0,spreadRadius: 0.1)],
                    ),
                    child: new InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                          new MaterialPageRoute(
                              builder: (context)=>new VocabularyList(prefs: widget.prefs, title: '所有单词',label:'all')
                          )
                        );
                        super.dispose();
                      },
                      child: new Center(
                        child: new Text('所有单词',
                          textAlign: TextAlign.left,
                          style: new TextStyle(fontSize: 18.0,height: 1.5,color: Colors.indigo),
                        ),
                      ),
                    ),
                  ),),
                  new Expanded(
                    key: Key('value3'),
                    child: new Container(
                    margin: const EdgeInsets.only(top: 20.0,right: 10.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(8.0),
                      boxShadow: [new BoxShadow(color: Colors.black45,offset: Offset.zero,blurRadius: 5.0,spreadRadius: 0.1)],
                    ),
                    child: new InkWell(
                      onTap: (){
                        Navigator.push(context,
                            new MaterialPageRoute(
                                builder: (context)=>new VocabularyList(prefs: widget.prefs,title: '尚未学习',label:'unstudy')
                            )
                        );
                      },
                      child: new Center(
                        child: new Text('尚未学习',
                          textAlign: TextAlign.left,
                          style: new TextStyle(fontSize: 18.0,height: 1.5,color: Colors.purple),
                        ),
                      ),
                    ),
                  ),)
                ],
              ),
            ),),
            new Expanded(
              key: Key('value4'),
              child: new Container(
              child: new Column(
                children: <Widget>[
                  new Expanded(child: new Container(
                    margin: const EdgeInsets.only(left: 10.0),
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(8.0),
                      boxShadow: [new BoxShadow(color: Colors.black45,offset: Offset.zero,blurRadius: 5.0,spreadRadius: 0.1)],
                    ),
                    child: new InkWell(
                      onTap: (){
                        Navigator.push(context,
                            new MaterialPageRoute(
                                builder: (context)=>new VocabularyList(prefs: widget.prefs,title: '正在学习',label:'studying')
                            )
                        );
                      },
                      child: new Center(
                        child: new Text('正在学习',
                          textAlign: TextAlign.left,
                          style: new TextStyle(fontSize: 18.0,height: 1.5,color: Colors.blue),
                        ),
                      ),
                    ),
                  ),),
                  new Expanded(
                      key: Key('value5'),
                      child: new Container(
                      margin: const EdgeInsets.only(top: 20.0,left:10.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.circular(8.0),
                        boxShadow: [new BoxShadow(color: Colors.black45,offset: Offset.zero,blurRadius: 5.0,spreadRadius: 0.1)],
                      ),
                      child: new InkWell(
                        onTap: (){
                          Navigator.push(context,
                              new MaterialPageRoute(
                                  builder: (context)=>new VocabularyList(prefs: widget.prefs,title: '已经掌握',label:'studied')
                              )
                          );
                        },
                        child: new Center(
                          child: new Text('已经掌握',
                            textAlign: TextAlign.left,
                            style: new TextStyle(fontSize: 18.0,height: 1.5,color: Colors.green),
                          ),
                        ),
                      )
                  ),),
                ],
              ),
            ),),
          ],
        ),
      ),
    );
  }
}