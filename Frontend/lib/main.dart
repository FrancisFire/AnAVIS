import 'package:anavis/pages/donor_avis.dart';
import 'package:anavis/pages/office_avis.dart';
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
        primaryColor: Colors.white,
      ),
      home: BuildTab(),
    );
  }
}

class BuildTab extends StatelessWidget {
  const BuildTab({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
              Text("Donatore AVIS"),
              Text("Ufficio AVIS"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RaisedButton(
              child: Icon(Icons.face),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DonorAvis();
                }));
              },
            ),
            RaisedButton(
              child: Icon(Icons.face),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OfficeAvis();
                }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
