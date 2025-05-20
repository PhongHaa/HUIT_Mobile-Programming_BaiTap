import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/expense.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'expenses.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE expenses(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT NOT NULL,
          amount REAL NOT NULL,
          note TEXT,
          date TEXT NOT NULL
        )
        ''');
      },
    );
  }

  // Thêm chi tiêu mới
  Future<int> insertExpense(Expense expense) async {
    final db = await database;
    return await db.insert('expenses', expense.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Lấy danh sách chi tiêu
  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses', orderBy: 'date DESC');
    return List.generate(maps.length, (i) {
      return Expense.fromMap({
        'id': maps[i]['id'],
        'title': maps[i]['title'],
        'amount': maps[i]['amount'],
        'note': maps[i]['note'],
        'date': maps[i]['date'],
      });
    });
  }

  // Cập nhật chi tiêu
  Future<int> updateExpense(Expense expense) async {
    final db = await database;
    return await db.update(
      'expenses',
      expense.toMap(),
      where: "id = ?",
      whereArgs: [expense.id],
    );
  }

  // Xóa chi tiêu
  Future<int> deleteExpense(int id) async {
    final db = await database;
    return await db.delete(
      'expenses',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  // Tính tổng chi tiêu
  Future<double> getTotalExpense() async {
    final db = await database;
    final result = await db.rawQuery('SELECT SUM(amount) as total FROM expenses');
    return result.first['total'] == null ? 0.0 : result.first['total'] as double;
  }
}
