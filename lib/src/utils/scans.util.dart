import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/src/models/scan.model.dart' as model;
import 'package:url_launcher/url_launcher.dart';
export 'package:url_launcher/url_launcher.dart';

openScan(BuildContext context, model.ScanModel scan) async {
  if (scan.type == 'http') {
    if (await canLaunch(scan.value)) {
      await launch(scan.value);
    } else {
      throw 'Could not launch ${scan.value}';
    }
  } else {
    Navigator.pushNamed(context,'map',arguments: scan);
  }
}
