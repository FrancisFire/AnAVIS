import 'package:anavis/model/app_state.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class OfficeView extends StatefulWidget {
  @override
  _OfficeViewState createState() => _OfficeViewState();
}

class _OfficeViewState extends State<OfficeView> {
  String _officeName;
  @override
  Widget build(BuildContext context) {
    _officeName = Provider.of<AppState>(context).getOfficeName();
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
                      _officeName,
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
                            'Numeri utili',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FabCircularMenu(
              child: Container(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        top: (MediaQuery.of(context).size.height / 3.5),
                        bottom: 8,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Colors.white,
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(26.0),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "Possiamo mostrare delle cose qui che possono essere un grafico o un calendario",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: 10,
                            itemWidth: 330.0,
                            itemHeight:
                                (MediaQuery.of(context).size.height / 1.6),
                            layout: SwiperLayout.STACK,
                          ),
                        ),
                      ),
                    ],
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
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/office/requests',
                arguments: _officeName,
              );
              /* Navigator.push(context, MaterialPageRoute(builder: (context) {
                return OfficeRequestView(
                  officeName: widget.office,
                );
              }));*/
            },
            label: Text(
              "Visualizza richieste \ndi donazioni",
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
              Icons.add,
              color: Colors.red,
            ),
            onPressed: () {},
            label: Text(
              "Aggiungi prenotazione \ndonazione",
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
