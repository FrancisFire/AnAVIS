import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OfficeAvis extends StatefulWidget {
  @override
  _OfficeAvisState createState() => _OfficeAvisState();
}

class _OfficeAvisState extends State<OfficeAvis> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 46, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Flexible(
                    child: AutoSizeText(
                      'Ufficio AVIS di',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.red,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Flexible(
                    child: AutoSizeText(
                      'Fabriano',
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
                  SizedBox(
                    height: 16,
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
              fabOpenIcon: Icon(
                FontAwesomeIcons.tint,
              ),
              ringDiameter: MediaQuery.of(context).size.width * 1.1,
              options: buildRaisedButtonFAB(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRaisedButtonFAB() {
    return <Widget>[
      RotationTransition(
        turns: new AlwaysStoppedAnimation(5 / 360),
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
        turns: new AlwaysStoppedAnimation(5 / 360),
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
              Icons.check_circle,
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
        turns: new AlwaysStoppedAnimation(5 / 360),
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
              Icons.location_city,
              color: Colors.red,
            ),
            onPressed: () {},
            label: Text(
              "Profilo \nAVIS",
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
