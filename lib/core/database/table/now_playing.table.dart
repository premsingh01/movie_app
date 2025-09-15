// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart';

class NowPlayingTable {
  static const String tableName = "now_playing_movies";

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS $tableName(
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


