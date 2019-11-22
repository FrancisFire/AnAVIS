import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class OfficeAvis extends StatefulWidget {
  @override
  _OfficeAvisState createState() => _OfficeAvisState();
}

class _OfficeAvisState extends State<OfficeAvis> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 46, left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Ufficio AVIS di',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 26.0,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Fabriano',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 64.0,
                    ),
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      Chip(
                        backgroundColor: Colors.red,
                        elevation: 14,
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.web_asset,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                        label: Text(
                          'Sito principale',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Chip(
                        backgroundColor: Colors.red,
                        elevation: 14,
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.phone_in_talk,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                        label: Text(
                          'Numeri utili emergenze',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Flexible(
                  flex: 7,
                  fit: FlexFit.tight,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(26.0),
                      ),
                    ),
                    elevation: 28,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Possiamo mostrare delle cose qui che possono essere un grafico o un calendario",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          FabCircularMenu(
            child: Container(
              child: Center(
                child: Stack(
                  children: <Widget>[],
                ),
              ),
            ),
            ringColor: Colors.red,
            fabColor: Colors.red,
            options: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.calendar_today,
                ),
                onPressed: () {},
                iconSize: 48.0,
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(
                  Icons.check_box,
                ),
                onPressed: () {},
                iconSize: 48.0,
                color: Colors.white,
              ),
              IconButton(
                icon: Icon(
                  Icons.account_circle,
                ),
                onPressed: () {},
                iconSize: 48.0,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
