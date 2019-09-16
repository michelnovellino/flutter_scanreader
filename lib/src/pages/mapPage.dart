import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_qr_reader/src/models/scan.model.dart';

class MapPage extends StatefulWidget {
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final mapCtrl = MapController();
  String mapType = 'streets';
  @override
  Widget build(BuildContext context) {
    final ScanModel scan = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Qr Coordinates'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              mapCtrl.move(scan.getLatLng(), 15);
            },
          )
        ],
      ),
      floatingActionButton: _renderButton(context),
      body: Center(child: _renderMap(context, scan)),
    );
  }

  _renderMap(BuildContext context, ScanModel scan) {
    return FlutterMap(
      mapController: mapCtrl,
      options: MapOptions(center: scan.getLatLng(), zoom: 10),
      layers: [_createMap(), _createMarkup(scan)],
    );
  }

  _createMap() {
    return TileLayerOptions(
        urlTemplate: 'https://api.mapbox.com/v4/'
            '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
        additionalOptions: {
          'accessToken':
              'pk.eyJ1IjoibWljaGVsbm92ZWxsaW5vIiwiYSI6ImNrMG1ubzB6ajBwZnkzcHJtMm9tdWJ4MzMifQ.i8Oo4PMx2LE52A6cw3kxwg',
          'id': 'mapbox.$mapType'
        });
  }

  _createMarkup(ScanModel scan) {
    return MarkerLayerOptions(markers: <Marker>[
      Marker(
          width: 100,
          height: 100,
          point: scan.getLatLng(),
          builder: (context) {
            return Container(
                child: Icon(
              Icons.location_on,
              size: 45,
              color: Theme.of(context).primaryColor,
            ));
          }),
    ]);
  }

  FloatingActionButton _renderButton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.repeat),
      backgroundColor: Theme.of(context).primaryColor,
      onPressed: (){
        if(mapType == 'streets') {
          mapType ='dark';
        }else if(mapType == 'dark'){
          mapType = 'light';
        }else if(mapType == 'light'){
          mapType = 'outdoors';
        }else if(mapType == 'outdoors'){
          mapType = 'satellite';
        }else{
          mapType = 'streets';
        }

          setState(() {
            
          });

      },  
    );
  }
}
