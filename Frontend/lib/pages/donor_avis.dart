import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

class DonorAvis extends StatefulWidget {
  @override
  _DonorAvisState createState() => _DonorAvisState();
}

class _DonorAvisState extends State<DonorAvis> {
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
                    'Benvenuto',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 26.0,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    'John Doe',
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
                          child: Text(
                            'A',
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                        label: Text(
                          'Tipo di sangue',
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
                            Icons.map,
                            color: Colors.red,
                            size: 18,
                          ),
                        ),
                        label: Text(
                          'Il tuo centro AVIS',
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
                    elevation: 14,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(26.0),
                      ),
                    ),
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
                  Icons.add,
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
