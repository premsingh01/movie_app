import 'package:movie_app/core/database/table/movie.table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase instance = AppDatabase._init();
  static Database? _database;

  AppDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB("app.db");
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await MovieTable.createTable(db); // create Movie table
      },
    );
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}



// import 'dart:io';
// import 'package:drift/drift.dart';
// import 'package:drift/native.dart';
// import 'package:movie_app/core/database/table/movie.table.dart';
// import 'package:path/path.dart' as p;
// import 'package:path_provider/path_provider.dart';
// import 'dao/movie_dao.dart';

// part 'app_database.g.dart';

// @DriftDatabase(tables: [Movies], daos: [MovieDao])
// class AppDatabase extends _$AppDatabase {
//   AppDatabase() : super(_openConnection());

//   @override
//   int get schemaVersion => 1;
// }

// LazyDatabase _openConnection() {
//   return LazyDatabase(() async {
//     final folder = await getApplicationDocumentsDirectory();
//     final file = File(p.join(folder.path, 'app_db.sqlite'));
//     return NativeDatabase(file);
//   });
// }
