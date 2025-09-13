




// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';

class MovieTable {
  static const String tableName = "movies";

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName(
        id INTEGER PRIMARY KEY,
        backdrop_path TEXT,
        original_language TEXT,
        original_title TEXT,
        overview TEXT,
        popularity REAL,
        poster_path TEXT,
        release_date TEXT,
        title TEXT,
        vote_average REAL,
        vote_count INTEGER
      )
    ''');
  }
}




// import 'package:drift/drift.dart';

// class Movies extends Table {
//   IntColumn get id => integer()(); // primary key
//   BoolColumn get adult => boolean().withDefault(const Constant(false))();
//   TextColumn get backdropPath => text().nullable()();
//   TextColumn get originalLanguage => text().nullable()();
//   TextColumn get originalTitle => text().nullable()();
//   TextColumn get overview => text().nullable()();
//   RealColumn get popularity => real().nullable()();
//   TextColumn get posterPath => text().nullable()();
//   DateTimeColumn get releaseDate => dateTime().nullable()();
//   TextColumn get title => text().nullable()();
//   BoolColumn get video => boolean().withDefault(const Constant(false))();
//   RealColumn get voteAverage => real().nullable()();
//   IntColumn get voteCount => integer().nullable()();

//   @override
//   Set<Column> get primaryKey => {id};
// }


