import 'package:flutter/material.dart';
import 'package:collins_vocabulary/model/word.dart';
import 'package:audioplayer2/audioplayer2.dart';

class DetailMeans extends StatefulWidget {
  final Word word;
  final bool showCn;
  final bool showCollins;
  final bool showSentence;
  DetailMeans({Key key,this.word,this.showCn,this.showCollins,this.showSentence}):super(key:key);
  @override
  DetailMeansState createState() => new DetailMeansState();
}

class DetailMeansState extends State<DetailMeans> {

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  Widget buildExpalin(){
    return new Text(widget.word.explain);
  }

  Widget buildWithoutCollins(){
    return new Expanded(
        child: new Column(
          children: <Widget>[
            _buildCnTitle(),
            _buildCnContent()
          ],
        )
    );
  }

  Widget buildCollins(){
    return new Expanded(
        child: new ListView(
          primary: false,
          children: <Widget>[
            _buildCnTitle(),
            _buildCnContent(),
            _buildCollinsTitle(),
            _buildCollinsContent(),
          ],
        )
    );
  }

  Widget buildExample(BuildContext context,int index,int itemIndex){
    final example = widget.word.collins[itemIndex]['example'][index];
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new GestureDetector(
          onTap:() {
            new AudioPlayer().play(example['tts_mp3']);
          },
          child: new Text(example['ex'],
            style: new TextStyle(color: Colors.blue,fontSize: 16.0),
          ),
        ),
        new Padding(
          padding: const EdgeInsets.only(bottom: 8.0,top: 2.0),
          child: new Text(example['tran'],style: new TextStyle(color: Colors.blueGrey,fontSize: 16.0),),
        )
      ],
    );
  }

  Widget _buildCnTitle(){
    if(widget.showCn){
      return new Container(
        padding: const EdgeInsets.only(top:16.0,left: 16.0, bottom: 8.0),
        child: new Text('中文释义',
          style: new TextStyle(color: Colors.blueGrey,fontSize: 15.0,fontWeight: FontWeight.w900),
        ),
      );
    }else{
      return new Text('');
    }
  }

  Widget _buildCnContent(){
    if(widget.showCn){
      return new ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, int index){
          final cn = widget.word.cn_mean[index];
          return new Padding(
            padding: const EdgeInsets.only(left: 16.0,right:16.0,top: 2.0,bottom: 14.0),
            child: new Text('${cn['part']} ${cn['means'].join('; ')}',
              style: new TextStyle(fontSize: 14.0),
            ),
          );
        },
        itemCount: widget.word.cn_mean.length,
      );
    }else{
      return new Text('');
    }
  }

  Widget _buildCollinsTitle(){
    if(widget.showCollins && widget.word.collins[0]['def'].toString().isNotEmpty){
      return new Container(
        padding: const EdgeInsets.only(bottom:4.0,left: 16.0),
        child: new Text('柯林斯词典英英释义',
          style: new TextStyle(color: Colors.blueGrey,fontSize: 15.0,fontWeight: FontWeight.bold),
        ),
      );
    }else{
      return new Text('');
    }
  }

  Widget _buildCollinsContent(){
    if(widget.showCollins){
      return new ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemBuilder: (BuildContext context, int index){
          final en = widget.word.collins[index];
          return new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getCollinsContent(en, index),
              )
          );
        },
        itemCount: widget.word.collins.length,
      );
    }else{
      return new Text('');
    }
  }

  List<Widget> _getCollinsContent(en, index){
    if(widget.word.collins[0]['def'].toString().isNotEmpty){
      return [
        new Text('${en['def']}',style: new TextStyle(fontSize: 17.0,color: Colors.black87),),
        new Container(
          padding: const EdgeInsets.only(top: 4.0,bottom: 8.0),
          child:new Text('${en['tran']}',style: new TextStyle(fontSize: 17.0,color: Colors.black),),
        ),
        _buildCollinsExample(en,index),
      ];
    }else{
      return [
        _buildCollinsExample(en,index),
      ];
    }
  }

  Widget _buildCollinsExample(en,index){
    if(widget.showSentence){
      return new Container(
        color: new Color.fromRGBO(236, 236, 242, 1.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.only(top: 16.0,bottom:8.0,left: 16.0,right: 16.0),
        child: new ListView.builder(
          itemBuilder: (context,i){
            return buildExample(context,i,index);
          },
          shrinkWrap: true,
          primary: false,
          itemCount: en['example'].length,
        ),
      );
    }else{
      return new Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    if(widget.word.explain.toString().isEmpty){
      return buildExpalin();
    }
    if(widget.word.collins.toString().isEmpty){
      return buildWithoutCollins();
    }
    return buildCollins();
  }

}