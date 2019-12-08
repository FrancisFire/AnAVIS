import 'package:anavis/model/app_state.dart';
import 'package:anavis/widgets/clip_path.dart';
import 'package:anavis/widgets/fab_item.dart';
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
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: (MediaQuery.of(context).size.height / 3),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.red[800],
                    Colors.red[700],
                    Colors.red[600],
                    Colors.red[400],
                  ],
                ),
              ),
            ),
          ),
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
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                ),
                Flexible(
                  child: AutoSizeText(
                    _officeName,
                    style: TextStyle(
                      fontSize: 52,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      Chip(
                        backgroundColor: Colors.red[900],
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
                        backgroundColor: Colors.red[900],
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
                      top: (MediaQuery.of(context).size.height / 4),
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
                              (MediaQuery.of(context).size.height / 1.8),
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
            options: iconFAB(),
          ),
        ],
      ),
    );
  }

  List<Widget> iconFAB() {
    return <Widget>[
      BuildRaisedButtonFAB(
        icon: Icon(
          Icons.calendar_today,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/office/requests',
            arguments: _officeName,
          );
        },
      ),
      BuildRaisedButtonFAB(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/office/prenotations',
            arguments: _officeName,
          );
        },
      ),
      BuildRaisedButtonFAB(
        icon: Icon(
          Icons.present_to_all,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
      BuildRaisedButtonFAB(
        icon: Icon(
          Icons.location_city,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    ];
  }
}
