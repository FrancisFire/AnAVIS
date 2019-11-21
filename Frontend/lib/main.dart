import 'package:flutter/material.dart';

void main() => runApp(Homepage());

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Rubik',
        primaryColor: Colors.red,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("AnAVIS"),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Main page del progetto',
              )
            ],
          ),
        ),
      ),
    );
  }
}
