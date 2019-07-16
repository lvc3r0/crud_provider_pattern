import 'package:flutter/material.dart';
import '../model/person.dart';
import '../helper/database_helper.dart';

class PersonProvider extends ChangeNotifier {
  List<Person> _personList = new List<Person>();
  final DatabaseHelper db = DatabaseHelper.db;

  List<Person> get personList => _personList;

  set personList(List<Person> list) {
    _personList = list;
    notifyListeners();
  }

  saveOrUpdatePerson(Person person) async {
    if (person.id == null) {
      await DatabaseHelper.db.insert(person);
    } else {
      await DatabaseHelper.db.update(person);
    }
  }

  deletePerson(int id) async {
    await db.delete(id);
    notifyListeners();
  }

  updateListPerson() async {
    DatabaseHelper db = DatabaseHelper.db;
    Future<List<Person>> listPersonFuture = db.getPersonList();
    await listPersonFuture.then((list) {
      personList = list;
    });
    notifyListeners();
  }
}
