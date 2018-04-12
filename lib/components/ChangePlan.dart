import 'package:flutter/material.dart';

class ChangePlan extends StatefulWidget {
  final prefs;
  ChangePlan({Key key,this.prefs}) : super(key:key);

  @override
  ChangePlanState createState() => new ChangePlanState();
}

class ChangePlanState extends State<ChangePlan> {
  int count;
  @override
  void initState() {
    super.initState();
    setState((){
      count = widget.prefs.getInt('count');
    });
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
        appBar: new AppBar(
          elevation: 0.0,
          title: new Text('复习计划'),
        ),
        body: new Container(
          padding: const EdgeInsets.all(16.0),
          child: new CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: <Widget>[
              new SliverList(
                  delegate: new SliverChildBuilderDelegate(
                    (context,int){
                      return new Column(
                      children: <Widget>[
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('5'),
                          title: const Text('每天学习5个单词'),
                          value: 5,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('10'),
                          title: const Text('每天学习10个单词'),
                          value: 10,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('15'),
                          title: const Text('每天学习15个单词'),
                          value: 15,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('20'),
                          title: const Text('每天学习20个单词'),
                          value: 20,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('25'),
                          title: const Text('每天学习25个单词'),
                          value: 25,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('30'),
                          title: const Text('每天学习30个单词'),
                          value: 30,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('50'),
                          title: const Text('每天学习50个单词'),
                          value: 50,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('80'),
                          title: const Text('每天学习80个单词'),
                          value: 80,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('100'),
                          title: const Text('每天学习100个单词'),
                          value: 100,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('150'),
                          title: const Text('每天学习150个单词'),
                          value: 150,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('200'),
                          title: const Text('每天学习200个单词'),
                          value: 200,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        ),
                        new RadioListTile(
                          activeColor: Colors.blueGrey,
                          key: new Key('300'),
                          title: const Text('每天学习300个单词'),
                          value: 300,
                          groupValue: count,
                          onChanged: (value) { setState(() {
                            count = value;
                            widget.prefs.setInt('count', value);
                          }); },
                        )
                      ],
                    );
                    },
                    childCount: 1
                  )
              ),
            ],
          ),
        )
    );
  }
}