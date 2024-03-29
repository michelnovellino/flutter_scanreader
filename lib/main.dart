import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/src/pages/homePage.dart';
import 'package:flutter_qr_reader/src/pages/mapPage.dart';

void main() => runApp(Run());

class Run extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QrScanner',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) {
          return HomePage();
        },
        'map': (BuildContext context){
          return MapPage();
        }
      },
      theme: ThemeData(
          primaryColor: Colors.deepPurpleAccent,
        buttonColor: Colors.deepPurpleAccent
        )
    );
  }
}
