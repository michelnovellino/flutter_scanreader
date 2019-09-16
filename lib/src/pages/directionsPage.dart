import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/src/bloc/scans.bloc.dart';
import 'package:flutter_qr_reader/src/models/scan.model.dart';
import 'package:flutter_qr_reader/src/utils/scans.util.dart' as util;
import 'dart:io';

class DirectionsPage extends StatelessWidget {
  final scansBloc = ScansBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ScanModel>>(
      stream: scansBloc.scansStream,
      builder: (BuildContext context, AsyncSnapshot<List<ScanModel>> snapshot) {
        if (!snapshot.hasData) {
          print(snapshot.data);

          return Center(child: CircularProgressIndicator());
        }
        print(snapshot.data);

        final scans = snapshot.data;
        if (scans.length == 0) {
          return Center(
            child: Text('No hay información'),
          );
        }
        return ListView.builder(
          itemCount: scans.length,
          itemBuilder: (BuildContext context, int i) {
            return Dismissible(
              onDismissed: (direction) {
                scansBloc.deleteOne(scans[i].id);
              },
              background: Container(
                color: Colors.redAccent,
              ),
              key: UniqueKey(),
              child: ListTile(
                  leading: Icon(Icons.cloud_queue,
                      color: Theme.of(context).primaryColor),
                  title: Text(scans[i].value),
                  subtitle: Text('ID: ${scans[i].id}'),
                  trailing: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right,
                        color: Colors.redAccent),
                    onPressed: () async {
                      if (Platform.isIOS) {
                        await Future.delayed(Duration(milliseconds: 750));
                        util.openScan(context, scans[i]);
                      } else {
                        util.openScan(context, scans[i]);
                      }
                    },
                  )),
            );
          },
        );
      },
    );
  }
}
