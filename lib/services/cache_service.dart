import 'package:money_laundry/database/database_helper.dart';
import 'package:money_laundry/models/service.dart';
import 'package:sqflite/sqflite.dart';

class ServiceCacheService {
  Future<void> saveServices(List<Service> services) async {
    final db = await DatabaseHelper.instance.database;

    await db.delete('service_cache');

    final batch = db.batch();

    for (final service in services) {
      batch.insert('service_cache', {
        'id': service.id,
        'name': service.name,
        'price': service.price,
      }, conflictAlgorithm: ConflictAlgorithm.replace);
    }

    await batch.commit(noResult: true);
  }

  Future<List<Service>> getServices() async {
    final db = await DatabaseHelper.instance.database;

    final maps = await db.query('service_cache');

    return maps.map((map) {
      return Service(
        id: map['id'].toString(),
        name: map['name'].toString(),
        price: map['price'] as int,
      );
    }).toList();
  }

  Future<void> clearCache() async {
    final db = await DatabaseHelper.instance.database;

    await db.delete('service_cache');
  }
}
