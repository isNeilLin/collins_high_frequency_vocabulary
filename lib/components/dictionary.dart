import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:collins_vocabulary/model/word.dart';
import 'package:collins_vocabulary/common/detail_means.dart';

class Dictionary extends StatefulWidget {
  Dictionary({Key key}): super(key:key);

  @override
  State<StatefulWidget> createState(){
    return new DictionaryState();
  }
}

class DictionaryState extends State<Dictionary> {

  Word curWord;
  final TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      curWord = null;   
    });
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }

  _onChanged(e) {
    if(controller.text == ''){
      setState(() {
        curWord = null;
      });
    }
  }

  _onSubmit(e) async{
    final String val = controller.text;
    final response = await get('http://xtk.azurewebsites.net/BingDictService.aspx?Word=$val');
    setState(() {
      if(val.isEmpty){
        curWord = null;
      }else{
        curWord = _translateResponse(response);
      }
    });
  }

  _translateResponse(response){
    try{
      var json = jsonDecode(response.body);
      List parts = [];
      List example = [];
      json['defs'].forEach((item){
        parts.add({
          'part': item['pos'],
          'means': item['def'].split(';'),
        });
      });
      json['sams'].forEach((item){
        example.add({
          "ex": item['eng'],
          "tran": item['chn'],
          "tts_mp3": item['mp3Url'],
          "tts_size": 0
        });
      });
      List collins = [{
          'posp': '',
          'tran': '',
          'def': '',
          'example': example
      }];
      
      final wordTypeJson = {
        'word': json['word'],
        'ph_en': json['pronunciation']['BrE'],
        'ph_en_mp3': json['pronunciation']['BrEmp3'],
        'ph_am': json['pronunciation']['AmE'],
        'ph_am_mp3': json['pronunciation']['AmEmp3'],
        'parts': parts,
        'collins': collins,
      };
      return Word.fromJson(wordTypeJson);
    }catch(e){
      return null;
    }
  }

  _getResult(){
    if(curWord==null || curWord.text == null){
      return new Expanded(child:
       new Container(child: new Center(child: new Text(''),),)
      );
    }else{
      return new DetailMeans(word: curWord,showCn:true,showCollins:true,showSentence:true);
    }
  }



  @override
  Widget build(BuildContext context){
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: new Text('词典'),
      ),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: new TextField(
                style: const TextStyle(fontSize: 22.0,color: Colors.black87),
                decoration: const InputDecoration(
                  hintText: 'Input the word here...',
                  hintStyle: const TextStyle(fontSize: 16.0),
                  suffixIcon: const Icon(Icons.search),
                  contentPadding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0)
                ),
                controller: controller,
                onChanged: _onChanged,
                onSubmitted: _onSubmit,
              ),
            ),
            _getResult()
          ],
        )
      )
    );
  }
}