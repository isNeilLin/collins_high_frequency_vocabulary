import 'package:flutter/material.dart';
import 'package:collins_vocabulary/model/word.dart';
import 'package:audioplayer/audioplayer.dart';

class DetailMeans extends StatefulWidget {
  Word word;
  DetailMeans({Key key,this.word}):super(key:key);
  @override
  DetailMeansState createState() => new DetailMeansState();
}

class DetailMeansState extends State<DetailMeans> {
  AudioPlayer audioPlayer = new AudioPlayer();

  @override
  void initState(){
    super.initState();
    audioPlayer.setCompletionHandler(() async{
      await audioPlayer.stop();
    });
    audioPlayer.setErrorHandler((msg) {
      print('examplePlayer error : $msg');
    });
  }

  Widget buildExpalin(){
    return new Text(widget.word.explain);
  }

  Widget buildWithoutCollins(){
    return new Expanded(
        child: new Column(
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(top:16.0,left: 16.0),
              child: new Text('中文释义',
                style: new TextStyle(color: Colors.blueGrey,fontSize: 15.0,fontWeight: FontWeight.w900),
              ),
            ),
            new ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index){
                final cn = widget.word.cn_mean[index];
                return new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 2.0),
                  child: new Text('${cn['part']} ${cn['means'].join('; ')}',
                    style: new TextStyle(fontSize: 14.0),
                  ),
                );
              },
              itemCount: widget.word.cn_mean.length,
            )
          ],
        )
    );
  }

  Widget buildCollins(){
    return new Expanded(
        child: new ListView(
          primary: false,
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.only(bottom:4.0,left: 16.0),
              child: new Text('中文释义',
                style: new TextStyle(color: Colors.blueGrey,fontSize: 15.0,fontWeight: FontWeight.bold),
              ),
            ),
            new ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index){
                final cn = widget.word.cn_mean[index];
                return new Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: new Text('${cn['part']} ${cn['means'].join('; ')}',
                    style: new TextStyle(fontSize: 17.0),
                  ),
                );
              },
              itemCount: widget.word.cn_mean.length,
            ),
            new Container(
              padding: const EdgeInsets.only(top:14.0,bottom:4.0,left: 16.0),
              child: new Text('柯林斯词典英英释义',
                style: new TextStyle(color: Colors.blueGrey,fontSize: 15.0,fontWeight: FontWeight.bold),
              ),
            ),
            new ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index){
                final en = widget.word.collins[index];
                return new Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text('${en['def']}',style: new TextStyle(fontSize: 17.0,color: Colors.black87),),
                        new Container(
                          padding: const EdgeInsets.only(top: 4.0,bottom: 8.0),
                          child:new Text('${en['tran']}',style: new TextStyle(fontSize: 17.0,color: Colors.black),),
                        ),
                        new Container(
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
                        ),
                      ],
                    )
                );
              },
              itemCount: widget.word.collins.length,
            ),
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
          onTap:() async{
            await audioPlayer.play(example['tts_mp3']);
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

  @override
  Widget build(BuildContext context) {
    print(widget.word);
    print(widget.word.cn_mean);
    if(widget.word.explain.toString().isEmpty){
      return buildExpalin();
    }
    if(widget.word.collins.toString().isEmpty){
      return buildWithoutCollins();
    }
    return buildCollins();
  }

}