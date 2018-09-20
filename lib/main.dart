import 'package:flutter/material.dart';
import 'package:collins_vocabulary/components/category.dart';
import 'package:collins_vocabulary/components/wordcard.dart';
import 'package:collins_vocabulary/components/setting.dart';
import 'package:collins_vocabulary/components/dictionary.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

void main() async{
  runApp(new MyApp());
}

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
  Widget tabView;
  SharedPreferences prefs;
  PageController pageController;
  int currentIndex = 0;

  Future<SharedPreferences> initPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final level = prefs.getInt('level');
    if(level==null){
      prefs.setInt('level', 5);
      prefs.setInt('count', 50);
      prefs.setBool('showcollins',true);
      prefs.setBool('sentence',true);
      prefs.setBool('showCn',true);
      prefs.setBool('autoplay',true);
      prefs.setBool('en_ph',true);
    }
    prefs.remove('studied');
    final studied = prefs.getString('studied');
    if(studied==null){
      prefs.setString('studied', '');
      prefs.setInt('studying', 0);
    }
    return prefs;
  }
  
  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: currentIndex);
  }
  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void _onTap(int index){
    if(currentIndex-index==1||index-currentIndex==1){
      pageController.animateToPage(
        index, duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
    }else{
      pageController.jumpToPage(index);
    }
  }

  pageChanged(int page){
    setState(() {
      currentIndex = page;        
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new FutureBuilder(
        builder: (BuildContext context, snapshot){
          if(snapshot.hasData){
            return new PageView(
              controller: pageController,
              onPageChanged: pageChanged, 
              children: <Widget>[
                new RememberVocab(prefs:snapshot.data),
                new Dictionary(),
                new WordList(prefs:snapshot.data),
                new Mine(prefs:snapshot.data),
              ],
            );
          }
          return new Center(
            child: new CircularProgressIndicator(),
          );
        },
        future: initPrefs(),
      ),
      bottomNavigationBar: new BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
          iconSize: 24.0,
          items: [
            new BottomNavigationBarItem(
                icon: new Icon(Icons.home,size: 24.0,),
                title: new Text('背词',style: new TextStyle(fontSize: 12.0)),
            ),
            new BottomNavigationBarItem(
                icon: new Icon(Icons.g_translate,size: 24.0,),
                title: new Text('词典',style: new TextStyle(fontSize: 12.0)),
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