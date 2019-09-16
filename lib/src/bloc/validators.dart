import 'dart:async';

import 'package:flutter_qr_reader/src/models/scan.model.dart';

class Validators {

  final validateGeo = StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where((el) => el.type ==  'geo').toList();
      sink.add(geoScans);
    }
  );
  final validateHttp= StreamTransformer<List<ScanModel>,List<ScanModel>>.fromHandlers(
    handleData: (scans, sink) {
      final geoScans = scans.where((el) => el.type ==  'http').toList();
      sink.add(geoScans);
    }
  );
  
}