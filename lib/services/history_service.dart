import 'package:money_laundry/database/database_helper.dart';
import 'package:money_laundry/models/order_history.dart';
import 'package:sqflite/sqflite.dart';

class HistoryService {
  Future<void> insert(OrderHistoryModel order) async {
    final db = await DatabaseHelper.instance.database;

    print("INSERT SQLITE");
    print(order.toMap());

    await db.insert(
      'order_history',
      order.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    print("INSERT SQLITE SUKSES");
  }

  Future<List<OrderHistoryModel>> getAll() async {
    final db = await DatabaseHelper.instance.database;

    final maps = await db.query('order_history', orderBy: 'createdAt DESC');

    return maps.map((e) => OrderHistoryModel.fromMap(e)).toList();
  }

  Future<void> delete(String id) async {
    final db = await DatabaseHelper.instance.database;

    await db.delete('order_history', where: 'id=?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    final db = await DatabaseHelper.instance.database;

    await db.delete('order_history');
  }
}
