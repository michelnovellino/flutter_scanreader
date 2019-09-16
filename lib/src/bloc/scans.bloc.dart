import 'dart:async';

import 'package:flutter_qr_reader/src/providers/db.provider.dart';

class ScansBloc {

  static final ScansBloc _instance = new ScansBloc._internal();
  factory ScansBloc(){
    return _instance;
  }
  ScansBloc._internal(){
  }

  final _scanController = StreamController<List<ScanModel>>.broadcast(); 


  Stream<List<ScanModel>> get scansStream {
    return _scanController.stream;
  }

  dispose(){
    _scanController?.close();
  }
  addOne(ScanModel scan) async {
    await DBProvider.db.newScan(scan);
     getAll();
  }
  getAll() async{
    _scanController.sink.add(await DBProvider.db.getScans());
  }
  deleteOne(int id) async {
    final result = await DBProvider.db.deleteScan(id);
    getAll();
    return result;
  }
  deleteAll() async {
    DBProvider.db.deleteAll();
    getAll();
  }
}