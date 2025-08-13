class SqlfliteFile {
  static const String tableName = 'notes';
  static const String columnId = 'id';
  static const String columnTitle = 'title';
  static const String columndescription = 'description';
  static const String columnImage = 'image';
  static const String columnTime = 'columntime';
  static const String columnIsDeleted = 'columnIsDeleted';

  static const String createTableQuery = '''
    CREATE TABLE $tableName (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTitle TEXT,
      $columndescription TEXT,
      $columnImage TEXT,
      $columnTime TEXT,
      $columnIsDeleted INTEGER DEFAULT 0
    )
  ''';

  static const String altertabe2 =
      'ALTER TABLE $tableName ADD COLUMN $columnIsDeleted INTEGER DEFAULT 0';
}
