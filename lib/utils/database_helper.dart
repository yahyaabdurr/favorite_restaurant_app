import 'package:favorite_restaurant_app/data/models/restaurant_detail.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  static const String _tableName = 'favorites';

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             city TEXT,
             rating REAL,
             pictureId TEXT
             )''',
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertFavorite(RestaurantDetail rest) async {
    final Database db = await database;
    await db.insert(_tableName, rest.toMap());
    print('data saved');
  }

  Future<List<RestaurantDetail>> getFavorites() async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(_tableName);

    return results.map((res) => RestaurantDetail.fromMap(res)).toList();
  }

  Future getFavoriteById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
    if (results.length > 0) {
      return results.map((res) => RestaurantDetail.fromMap(res)).first;
    } else {
      return null;
    }
  }

  Future<void> deleteFavorite(String id) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
