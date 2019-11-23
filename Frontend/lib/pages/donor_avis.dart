import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';

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
                  child: AutoSizeText(
                    'Benvenuto',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.red,
                    ),
                    maxLines: 1,
                  ),
                ),
                Flexible(
                  child: AutoSizeText(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 64,
                      color: Colors.red,
                    ),
                    maxLines: 1,
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
            fabOpenIcon: Icon(
              FontAwesomeIcons.tint,
            ),
            options: buildRaisedButtonFAB(),
          ),
        ],
      ),
    );
  }

  List<Widget> buildRaisedButtonFAB() {
    return <Widget>[
      RotationTransition(
        turns: new AlwaysStoppedAnimation(10 / 360),
        child: SizedBox(
          height: 60,
          child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(64.0),
              ),
            ),
            color: Colors.white,
            elevation: 28.0,
            icon: Icon(
              Icons.calendar_today,
              color: Colors.red,
            ),
            onPressed: () {},
            label: Text(
              "Visualizza possibilità \ndi donare",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
      RotationTransition(
        turns: new AlwaysStoppedAnimation(10 / 360),
        child: SizedBox(
          height: 60,
          child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(64.0),
              ),
            ),
            color: Colors.white,
            elevation: 28.0,
            icon: Icon(
              Icons.add,
              color: Colors.red,
            ),
            onPressed: () {},
            label: Text(
              "Richiedi prenotazione \ndonazioni",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
      RotationTransition(
        turns: new AlwaysStoppedAnimation(10 / 360),
        child: SizedBox(
          height: 60,
          child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(64.0),
              ),
            ),
            color: Colors.white,
            elevation: 28.0,
            icon: Icon(
              Icons.account_circle,
              color: Colors.red,
            ),
            onPressed: () {},
            label: Text(
              "Profilo \nutente",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    ];
  }
}
