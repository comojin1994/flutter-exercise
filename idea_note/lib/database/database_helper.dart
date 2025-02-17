import 'package:idea_note/data/idea_info.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database database;

  // Initialization
  Future<void> initDatabase() async {
    String path = join(await getDatabasesPath(), 'idea_note.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE IF NOT EXISTS tb_idea_note (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            motive TEXT,
            content TEXT,
            priority INTEGER,
            feedback TEXT,
            createdAt INTEGER
          )
        ''');
      },
    );
  }

  // Insert
  Future<int> insertIdeaInfo(IdeaInfo idea) async {
    return await database.insert('tb_idea_note', idea.toMap());
  }

  // Select
  Future<List<IdeaInfo>> getAllIdeaInfo() async {
    final List<Map<String, dynamic>> results =
        await database.query('tb_idea_note');
    return List.generate(
      results.length,
      (index) {
        return IdeaInfo.fromMap(results[index]);
      },
    );
  }

  // Update
  Future<int> updateIdeaInfo(IdeaInfo idea) async {
    return await database.update(
      'tb_idea_note',
      idea.toMap(),
      where: 'id = ?',
      whereArgs: [idea.id],
    );
  }

  // Delete
  Future<int> deleteIdeaInfo(int id) async {
    return await database.delete(
      'tb_idea_note',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Close
  Future<void> closeDatabase() async {
    await database.close();
  }
}
