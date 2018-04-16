import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectBook extends StatefulWidget {
  SharedPreferences prefs;
  SelectBook({Key key,this.prefs}) : super(key:key);

  @override
  SelectBookState createState() => new SelectBookState();
}

class SelectBookState extends State<SelectBook> {
  int level;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState((){
      level = widget.prefs.getInt('level');
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: new Text('选择单词书'),
      ),
      body: new Container(
        padding: const EdgeInsets.all(16.0),
        child: new Column(
          children: <Widget>[
            new RadioListTile(
              activeColor: Colors.blueGrey,
              title: const Text('柯林斯一星词汇'),
              value: 1,
              groupValue: level,
              onChanged: (int value) { setState(() {
                level = value;
                widget.prefs.setInt('level', value);
              }); },
            ),
            new RadioListTile(
              activeColor: Colors.blueGrey,
              title: const Text('柯林斯二星词汇'),
              value: 2,
              groupValue: level,
              onChanged: (int value) { setState(() {
                level = value;
                widget.prefs.setInt('level', value);
              }); },
            ),
            new RadioListTile(
              activeColor: Colors.blueGrey,
              title: const Text('柯林斯三星词汇'),
              value: 3,
              groupValue: level,
              onChanged: (int value) { setState(() {
                level = value;
                widget.prefs.setInt('level', value);
              }); },
            ),
            new RadioListTile(
              activeColor: Colors.blueGrey,
              title: const Text('柯林斯四星词汇'),
              value: 4,
              groupValue: level,
              onChanged: (int value) { setState(() {
                level = value;
                widget.prefs.setInt('level', value);
              }); },
            ),
            new RadioListTile(
              activeColor: Colors.blueGrey,
              title: const Text('柯林斯五星词汇'),
              value: 5,
              groupValue: level,
              onChanged: (int value) { setState(() {
                level = value;
                widget.prefs.setInt('level', value);
              }); },
            ),
          ],
        ),
      )
    );
  }
}