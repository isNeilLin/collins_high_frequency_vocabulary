import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collins_vocabulary/components/word_detail.dart';
import 'package:collins_vocabulary/model/word.dart';

class VocabularyList extends StatefulWidget {
  SharedPreferences prefs;
  String title;
  VocabularyList({Key key,this.prefs,this.title}) : super(key:key);
  
  

  @override
  State<StatefulWidget> createState() {
    return new VocabularyListState();
  }
}

class VocabularyListState extends State<VocabularyList> {
  List list;
  Widget buildItem(BuildContext context,int index){
    Word item = new Word().getDetail(list[index]);
    return new Card(
      elevation: 0.5,
      color: Colors.white70,
      child: new GestureDetector(
        child: new Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0,horizontal: 16.0),
          child: new Text(item.text,style: new TextStyle(fontSize: 20.0),),
        ),
        onTap: (){
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (context) => new WordDetail(item:item,prefs: widget.prefs)
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: new Text(widget.title),
      ),
      body: new FutureBuilder(
          future: new Word().getList(widget.prefs.getInt('level')),
          builder: (context, snapshot){
            if(snapshot.hasData){
              list = snapshot.data;
              return new ListView.builder(itemBuilder: buildItem,itemCount: list.length,);
            }
            return new Container(child: null,);
          }
      ),
    );
  }
}