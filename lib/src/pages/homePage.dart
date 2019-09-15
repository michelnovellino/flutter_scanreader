import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';
import 'package:flutter_qr_reader/src/pages/directionsPage.dart';
import 'package:flutter_qr_reader/src/pages/mapsPage.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}
/* http://michelnovellino.com/
geo:40.71668710772393,-73.99564161738283
 */class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QrScanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever),
          onPressed: (){},)
        ],
              backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: _setPage(currentIndex),
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          _scan();
        },
        child: Icon(Icons.keyboard_capslock),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
  Widget _setPage(int view){
    switch(view) {
      case 0 : return MapsPage();
      case 1 : return DirectionsPage();
      default: return MapsPage();
    }
  }
  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index){
        setState(() {
          currentIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Container()),
        BottomNavigationBarItem(icon: Icon(Icons.directions), title: Container())
      ],
    );
  }
  _scan() async {
    String response = '';
/*     try{
      response = await new QRCodeReader().scan();
    }catch(error) {
      response = error.toString();
    }

    if(response != null) {
      print('qr >>> $response');
    } */
  }
}