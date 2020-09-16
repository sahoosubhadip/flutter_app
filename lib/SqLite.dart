import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqLite {
  setup() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'note.db');

    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE note (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, note TEXT,creatdate DATE, updateddate DATE, attach_file TEXT, created_by TEXT )');
    });
  }

  connect() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'note.db');
    return await openDatabase(path, version: 1);
  }

  add_data(table, data) async {
    var db = await connect();
     await db.insert(table, data);

  }

  delete_data() {}

  edit_data() {}

  search_note() {}



  getNote()async{
    final db = await connect();
   return await db.rawQuery("SELECT * FROM note");

  }




}
