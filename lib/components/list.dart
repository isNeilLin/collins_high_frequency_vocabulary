import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collins_vocabulary/components/alllist.dart';

class WordList extends StatelessWidget {
  SharedPreferences prefs;
  WordList({Key key,this.prefs}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: new Text('分类列表'),
      ),
      body: new Column(
        children: <Widget>[
          new Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              height: 66.0,
              constraints: new BoxConstraints(
                  minWidth: double.maxFinite
              ),
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(color: Colors.grey,width: 1.0)
                  )
              ),
              child: new InkWell(
                onTap: (){
                  Navigator.push(context,
                      new MaterialPageRoute(
                          builder: (context)=>new VocabularyList(prefs: prefs, title: '所有单词',label:'all')
                      )
                  );
                },
                child: new Text('所有单词',
                  textAlign: TextAlign.left,
                  style: new TextStyle(fontSize: 18.0,height: 1.5,color: Colors.indigo),
                ),
              )
          ),
          new Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              height: 66.0,
              constraints: new BoxConstraints(
                  minWidth: double.maxFinite
              ),
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(color: Colors.grey,width: 1.0)
                  )
              ),
              child: new InkWell(
                onTap: (){
                  Navigator.push(context,
                      new MaterialPageRoute(
                          builder: (context)=>new VocabularyList(prefs: prefs,title: '尚未学习',label:'unstudy')
                      )
                  );
                },
                child: new Text('尚未学习',
                  textAlign: TextAlign.left,
                  style: new TextStyle(fontSize: 18.0,height: 1.5,color: Colors.purple),
                ),
              )
          ),
          new Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              height: 66.0,
              constraints: new BoxConstraints(
                  minWidth: double.maxFinite
              ),
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(color: Colors.grey,width: 1.0)
                  )
              ),
              child: new InkWell(
                onTap: (){
                  Navigator.push(context,
                      new MaterialPageRoute(
                          builder: (context)=>new VocabularyList(prefs: prefs,title: '正在学习',label:'studying')
                      )
                  );
                },
                child: new Text('正在学习',
                  textAlign: TextAlign.left,
                  style: new TextStyle(fontSize: 18.0,height: 1.5,color: Colors.blue),
                ),
              )
          ),
          new Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
              height: 66.0,
              constraints: new BoxConstraints(
                  minWidth: double.maxFinite
              ),
              decoration: new BoxDecoration(
                  border: new Border(
                      bottom: new BorderSide(color: Colors.grey,width: 1.0)
                  )
              ),
              child: new InkWell(
                onTap: (){
                  Navigator.push(context,
                      new MaterialPageRoute(
                          builder: (context)=>new VocabularyList(prefs: prefs,title: '已经掌握',label:'studied')
                      )
                  );
                },
                child: new Text('已经掌握',
                  textAlign: TextAlign.left,
                  style: new TextStyle(fontSize: 18.0,height: 1.5,color: Colors.green),
                ),
              )
          ),
        ],
      ),
    );
  }
}