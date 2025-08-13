import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'sqlflite_file.dart';

class SqlfliteServer {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = await getDatabasesPath();
    String dbPath = join(path, 'mydatabase.db');
    Database database = await openDatabase(
      dbPath,
      version: 3,
      onCreate: _oncreateDatabase,
      onUpgrade: _onUpgradeDatabase,
    );
    return database;
  }

  Future<void> _oncreateDatabase(Database db, int version) async {
    await db.execute(SqlfliteFile.createTableQuery);
    print('✅ Database & Table created successfully');
  }

  Future<void> _onUpgradeDatabase(
      Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 3) {
      await db.execute(SqlfliteFile.altertabe2);
      print('✅ Table updated: isDeleted column added');
    }
  }

  Future insertdata(
      String title, String description, String image, String date) async {
    final db = await database;
    return await db.insert(SqlfliteFile.tableName, {
      SqlfliteFile.columnTitle: title,
      SqlfliteFile.columndescription: description,
      SqlfliteFile.columnImage: image,
      SqlfliteFile.columnTime: date,
      SqlfliteFile.columnIsDeleted: 0,
    });
  }

  Future<List<Map<String, dynamic>>> getActiveNotes(
      {bool newest = true}) async {
    final db = await database;
    return db.query(
      SqlfliteFile.tableName,
      where: '${SqlfliteFile.columnIsDeleted} = 0',
      orderBy: newest
          ? "${SqlfliteFile.columnTime} DESC"
          : "${SqlfliteFile.columnTime} ASC",
    );
  }

  Future<List<Map<String, dynamic>>> getTrashNotes() async {
    final db = await database;
    return db.query(
      SqlfliteFile.tableName,
      where: '${SqlfliteFile.columnIsDeleted} = 1',
      orderBy: "${SqlfliteFile.columnTime} DESC",
    );
  }

  Future<int> moveToTrash(int id) async {
    final db = await database;
    return await db.update(
      SqlfliteFile.tableName,
      {SqlfliteFile.columnIsDeleted: 1},
      where: '${SqlfliteFile.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> restoreFromTrash(int id) async {
    final db = await database;
    return await db.update(
      SqlfliteFile.tableName,
      {SqlfliteFile.columnIsDeleted: 0},
      where: '${SqlfliteFile.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteForever(int id) async {
    final db = await database;
    return await db.delete(
      SqlfliteFile.tableName,
      where: '${SqlfliteFile.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateData(
      int id, String title, String description, String image, String date) async {
    final db = await database;
    return await db.update(
      SqlfliteFile.tableName,
      {
        SqlfliteFile.columnTitle: title,
        SqlfliteFile.columndescription: description,
        SqlfliteFile.columnImage: image,
        SqlfliteFile.columnTime: date,
      },
      where: '${SqlfliteFile.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<List<Map<String, dynamic>>> searchByTitle(String title) async {
    final db = await database;
    return db.query(
      SqlfliteFile.tableName,
      where:
          '${SqlfliteFile.columnTitle} LIKE ? AND ${SqlfliteFile.columnIsDeleted} = 0',
      whereArgs: ['%$title%'],
    );
  }
}
