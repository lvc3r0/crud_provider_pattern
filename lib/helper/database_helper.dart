import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/person.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper db = DatabaseHelper._();
  Database _database;
  final String tablename = 'person';
  final String columnId = 'id';

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await getDatabaseInstance();
    return _database;
  }

  getDatabaseInstance() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'my.db');
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''create table $tablename (id integer primary key
       autoincrement,surname text, firstname text, dni text, sex 
       integer, address integer)''');
    });
  }

  Future<Person> insert(Person person) async {
    final db = await database;
    person.id = await db.insert(tablename, person.toMap());
    return person;
  }

  Future<int> delete(int id) async {
    final db = await database;
    return await db.delete(tablename, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Person person) async {
    final db = await database;
    return await db.update(tablename, person.toMap(),
        where: '$columnId = ?', whereArgs: [person.id]);
  }

  Future<List<Person>> getPersonList() async {
    final db = await database;
    var result = await db.query(tablename);
    List<Person> list =
        result.isNotEmpty ? result.map((c) => Person.fromJson(c)).toList() : [];
    return list;
  }

  Future<Person> getPerson(int id) async {
    final db = await database;
    List<Map> results =
        await db.query(tablename, where: '$columnId = ?', whereArgs: [id]);
    if (results.length > 0) {
      return Person.fromJson(results.first);
    }
    return null;
  }

  Future close() async {
    final db = await database;
    db.close();
  }
}
