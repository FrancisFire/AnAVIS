import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

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
        primaryColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "AnAVIS",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
            bottom: TabBar(
              labelColor: Colors.red,
              indicatorColor: Colors.redAccent,
              labelPadding: EdgeInsets.all(12.0),
              tabs: <Widget>[
                buildTextTabBar("Donatore AVIS"),
                buildTextTabBar("Cittadino"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.face),
              Icon(Icons.face),
            ],
          ),
        ),
      ),
    );
  }

  Text buildTextTabBar(String message) {
    return Text(
      message,
    );
  }
}
