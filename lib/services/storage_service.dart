import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_info.dart';

class StorageService {
  StorageService._();

  static final StorageService instance = StorageService._();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initStorage('user_info.db');
    return _database;
  }

  Future<Database> _initStorage(String filePath) async {
    final storagePath = await getDatabasesPath();
    final path = join(storagePath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createStorage);
  }

  Future _createStorage(Database db, int version) async {
    db.execute('''
    CREATE TABLE user_info (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT,
    email TEXT,
    profileImagePath TEXT
    )
    ''');
  }

  Future<void> insertOrUpdateUser(UserInfo userInfo) async {
    final storage = await instance.database;
    await storage?.delete('user_info'); // 기존 데이터 삭제
    await storage?.insert('user_info', userInfo.toMap()); // 새로운 데이터 삽입
  }

  Future<UserInfo?> getUserInfo() async {
    final storage = await instance.database;
    final userMaps = await storage?.query('user_info');
    if (userMaps != null && userMaps.isNotEmpty) {
      return UserInfo.fromMap(userMaps.first);

    }
    return null;
  }

  Future close() async {
    final storage = await instance.database;
    storage?.close();
  }
}
