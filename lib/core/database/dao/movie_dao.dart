import 'package:sqflite/sqflite.dart';
import '../app_database.dart';

class MovieDao {
  final table = "movies";

  /// Insert a single movie
  Future<int> insertMovie(Map<String, dynamic> movie) async {
    final db = await AppDatabase.instance.database;
    return await db.insert(
      table,
      movie,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  /// Insert multiple movies in a batch
  Future<void> insertMovies(List<Map<String, dynamic>> movies) async {
    final db = await AppDatabase.instance.database;
    final batch = db.batch();
    for (var movie in movies) {
      batch.insert(
        table,
        movie,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  /// Get all movies
  Future<List<Map<String, dynamic>>> getMovies() async {
    final db = await AppDatabase.instance.database;
    return await db.query(table);
  }

  /// Delete a movie by ID
  Future<int> deleteMovie(int id) async {
    final db = await AppDatabase.instance.database;
    return await db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  /// Clear all movies
  Future<int> clearMovies() async {
    final db = await AppDatabase.instance.database;
    return await db.delete(table);
  }

  /// Check if a movie is saved by ID
  Future<bool> isSaved(int id) async {
    final db = await AppDatabase.instance.database;
    final result = await db.query(
      table,
      columns: const ["id"],
      where: "id = ?",
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }
}



// import 'package:drift/drift.dart';
// import '../app_database.dart';
// import '../tables/movie_table.dart';

// part 'movie_dao.g.dart';

// @DriftAccessor(tables: [Movies])
// class MovieDao extends DatabaseAccessor<AppDatabase> with _$MovieDaoMixin {
//   final AppDatabase db;
//   MovieDao(this.db) : super(db);

//   // Insert multiple movies (batch insert with upsert)
//   Future<void> insertMovies(List<MoviesCompanion> movies) async {
//     await batch((batch) {
//       batch.insertAllOnConflictUpdate(moviesTable, movies);
//     });
//   }

//   // Get all movies
//   Future<List<Movie>> getAllMovies() => select(moviesTable).get();

//   // Get a single movie
//   Future<Movie?> getMovieById(int id) =>
//       (select(moviesTable)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

//   // Delete all
//   Future<int> clearMovies() => delete(moviesTable).go();
// }
