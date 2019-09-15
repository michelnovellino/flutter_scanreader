import 'package:flutter_qr_reader/src/models/scan.model.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  static Database _database;
  static final DBProvider dbProvider = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
  }

  initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'ScanDB.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Scans('
          'id INTEGER  PRIMARY KEY,'
          'type TEXT,'
          'value TEXT'
          ')');
    });
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;
    final result = await db.query('Scans');
    List<ScanModel> list = result.isNotEmpty
        ? result.map((el) {
            return ScanModel.fromJson(el);
          }).toList()
        : [];

    return list;
  }
  Future<List<ScanModel>> getScansByType(String type) async {
    final db = await database;
    final result = await db.rawQuery(
      "SELECT * FROM Scans WHERE type='$type'"
    );
    List<ScanModel> list = result.isNotEmpty
        ? result.map((el) {
            return ScanModel.fromJson(el);
          }).toList()
        : [];

    return list;
  }
  getScanId(int id) async {
    final db = await database;
    final result = await db.query('Scans', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? ScanModel.fromJson(result.first) : null;
  }

  addScan(ScanModel newScan) async {
    final db = await database;
    final result = await db.insert('Scans', newScan.toJson());
    return result;
  }
  updateScan(ScanModel scan)  async {
    final db = await database;
    final result = await db.update('Scans', scan.toJson(),where: 'id = ?',whereArgs: [scan.id]);
    return result;
  }
  deleteScan(int id) async{
    final db = await database;
    final result = await db.delete('Scans',where: 'id = ?', whereArgs: [id]);
    return result;
  }
    resetScans() async{
    final db = await database;
    final result = await db.rawDelete(
      'DELETE * FROM Scans'
    );
    return result;
  }

/*  otro modo de insertar
  newScan(ScanModel newScan) async{
    final db = await database;
    final result = await db.rawInsert(
      'INSERT INTO Scans (id,type,value) '
      "VALUES (${newScan.id}, '${newScan.type }', '${newScan.value}')"
    );
    return result;
  } */

}
