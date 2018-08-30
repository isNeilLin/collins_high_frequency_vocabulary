import 'dart:io';
import 'dart:async';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:collins_vocabulary/model/word.dart';

final String studied = 'studied';
final String text = 'text';
final String ph_en = 'ph_en';
final String ph_en_mp3 = 'ph_en_mp3';
final String ph_am = 'ph_am';
final String ph_am_mp3 = 'ph_am_mp3';
final String explain = 'explain';


// database helper
class DBClient {

 static Database _db;

 Future<Database> get db async {
   if(_db==null){
     _db = await initDb();
   }
   return _db;
 }

  //Creating a database with name test.dn in your directory
  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, '$studied.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate, onOpen: _onOpen);
    return db;
  }

  void _onOpen(Database db) {
    print('open db');
  }

  void _onCreate(Database db, int newVersion) async{
    print('create db');
    await db.execute('''
      create table $studied (
        _id integer primary key autoincrement, 
        $text text not null,
        $ph_en text,
        $ph_en_mp3 text,
        $ph_am text,
        $ph_am_mp3 text,
        $explain text
      );
    ''');
  }

  Future<Word> insert(Word word) async {
    var client = await db;
    try{
      await client.insert('studied', {
        text: word.text,
        ph_en: word.ph_en,
        ph_en_mp3: word.ph_en_mp3,
        ph_am: word.ph_am,
        ph_am_mp3: word.ph_am_mp3,
        explain: word.explain
      });
    }catch(e){
      print(e);
    }
    print('inserted');
    return word;
  }

  Future<Word> queryById(int id) async {
    var client = await db;
    List<Map> maps = await client.query(studied,
      where: "_id = ?",
      whereArgs: [id]);
    print('query by $id');
    if(maps.length > 0) {
      return Word.fromJson(maps.first);
    }
    return null;
  }

  Future<List> queryAll() async {
    var client = await db;
    List<Map> maps = await client.query(studied);
    List words = [];
    maps.forEach((json){
      words.add(json['text']);
    });
    return words;
  }

  Future<int> delete(int id) async {
    print('delete');
    return await _db.delete(studied, where: "_id = ?", whereArgs: [id]);
  }

}
