import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collins_vocabulary/components/word_detail.dart';
import 'package:collins_vocabulary/model/word.dart';
import 'package:collins_vocabulary/model/db.dart';
import 'dart:async';

class VocabularyList extends StatefulWidget {
  final SharedPreferences prefs;
  final String title;
  final String label;
  VocabularyList({Key key,this.prefs,this.title,this.label}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    return new VocabularyListState();
  }
}

class VocabularyListState extends State<VocabularyList> {
  List list;
  DBClient client;

  @override
  initState(){
    super.initState();
    client = new DBClient();
  }

  @override
  dispose(){
    print('dispose');
    super.dispose();
  }

  Widget buildItem(BuildContext context,int index){
    Word item = new Word().getDetail(list[index]);
    return new Card(
      elevation: 0.5,
      key: Key(index.toString()),
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

  Future<List> getList() async{
    List wholeList = await new Word().getList(widget.prefs.getInt('level'));
    if(widget.label=='all'){
      return wholeList;
    }
    List studiedList =  await client.queryAll();
    if(widget.label=='studied'){
      List studied = wholeList.where((item){
        return studiedList.contains(item['word']);
      }).toList();
      return studied;
    }
    if(widget.label=='unstudy'){
      List unstudy = wholeList.where((item){
        return !studiedList.contains(item['word']);
      }).toList();
      return unstudy;
    }else{
      List lastWords = wholeList.where((item){
        return !studiedList.contains(item['word']);
      }).toList();
      int count = widget.prefs.getInt('count');
      int len = count > lastWords.length ? lastWords.length : count;
      return lastWords.sublist(0,len);
    }
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: new Text(widget.title),
      ),
      body: new FutureBuilder(
          future: getList(),
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