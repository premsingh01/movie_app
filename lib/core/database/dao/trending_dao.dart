import 'package:sqflite/sqflite.dart';
import '../app_database.dart';
import '../table/trending.table.dart';

class TrendingDao {
  final table = TrendingTable.tableName;

  Future<void> replaceAll(List<Map<String, dynamic>> rows) async {
    final db = await AppDatabase.instance.database;
    final batch = db.batch();
    await db.delete(table);
    for (final row in rows) {
      batch.insert(table, row, conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  Future<List<Map<String, dynamic>>> getAll() async {
    final db = await AppDatabase.instance.database;
    return db.query(table);
  }
}


