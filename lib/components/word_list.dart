import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:collins_vocabulary/components/word_detail.dart';
import 'package:collins_vocabulary/model/word.dart';
import 'dart:convert';

class VocabularyList extends StatefulWidget {
  SharedPreferences prefs;
  String title;
  String label;
  VocabularyList({Key key,this.prefs,this.title,this.label}) : super(key:key);

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

  List generateList(List list){
    if(widget.label=='all'){
      return list;
    }
    List studiedList = [];
    final studied = widget.prefs.getString('studied');
    if(studied.isEmpty){
      studiedList = [];
    }else{
      List strlist = json.decode(studied);
      strlist.forEach((item){
        studiedList.add(json.decode(item));
      });
    }
    List stuiedWords = studiedList.map((item)=>item['word']).toList();
    if(widget.label=='studied'){
      return studiedList;
    }
    if(widget.label=='unstudy'){
      List unstudy = list.where((item){
        return !stuiedWords.contains(item['word']);
      }).toList();
      return unstudy;
    }else{
      List lastWords = list.where((item){
        return !stuiedWords.contains(item['word']);
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
          future: new Word().getList(widget.prefs.getInt('level')),
          builder: (context, snapshot){
            if(snapshot.hasData){
              list = snapshot.data;
              list = generateList(list);
              return new ListView.builder(itemBuilder: buildItem,itemCount: list.length,);
            }
            return new Container(child: null,);
          }
      ),
    );
  }
}