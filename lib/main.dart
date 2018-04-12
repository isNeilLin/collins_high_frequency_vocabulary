import 'package:flutter/material.dart';
import 'package:collins_vocabulary/components/list.dart';
import 'package:collins_vocabulary/components/remember.dart';
import 'package:collins_vocabulary/components/mine.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: '柯林斯高频词汇',
      theme: new ThemeData(
        primaryIconTheme: const IconThemeData(color: Colors.white),
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.cyan[300],
      ),
      home: new HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomePageState();
  }
}
class HomePageState extends State<HomePage>{
  Widget TabView;
  int currentIndex = 0;
  int level = 5;
  Map<String,bool> options = {

  };

  @override
  void initState() {
    super.initState();
    setState((){
      TabView = new RememberVocab(level:level,options:options);
    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  void _onTap(int index){
    setState((){
        currentIndex = index;
        switch(currentIndex) {
          case 0:
            TabView = new RememberVocab(level:level,options:options);
            break;
          case 1:
            TabView = new VocabularyList(level:level,options:options);
            break;
          case 2:
            TabView = new Mine();
            break;
          default:
            TabView = new RememberVocab();
        }
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title: new Text('柯林斯高频词汇'),
      ),
      body: TabView,
      bottomNavigationBar: new BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: _onTap,
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home,size: 24.0,),
                title: new Text('背单词',style: new TextStyle(fontSize: 12.0)),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.library_books,size: 24.0,),
              title: new Text('列表',style: new TextStyle(fontSize: 12.0),),
            ),
            new BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle,size: 24.0,),
              title: new Text('我的',style: new TextStyle(fontSize: 12.0),),
            ),
          ]
      )
    );
  }
}