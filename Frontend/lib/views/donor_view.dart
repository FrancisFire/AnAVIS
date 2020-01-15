import 'package:anavis/providers/app_state.dart';
import 'package:anavis/providers/current_donor_state.dart';
import 'package:anavis/widgets/button_fab_homepage.dart';
import 'package:anavis/widgets/clip_path.dart';
import 'package:anavis/widgets/value_blood_info.dart';
import 'package:badges/badges.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DonorView extends StatefulWidget {
  @override
  _DonorViewState createState() => _DonorViewState();
}

class _DonorViewState extends State<DonorView> {
  bool _donorCanDonate;
  String _email;

  bool showLegend = true;

  int prenotationCount = 0;
  int pendingCount = 0;
  int pendingRequestCount = 0;

  List<int> selectedSpots = [];
  int touchedIndex;
  int lastPanStartOnIndex = -1;

  int getPrenotationCount() {
    Provider.of<CurrentDonorState>(context).getDonorActivePrenotations().then(
      (onValue) {
        setState(() {
          prenotationCount = onValue.length;
        });
      },
    );
    return prenotationCount;
  }

  int getPendingCount() {
    Provider.of<CurrentDonorState>(context).getDonorPendingPrenotations().then(
      (onValue) {
        setState(() {
          pendingCount = onValue.length;
        });
      },
    );
    return pendingCount;
  }

  int getPendingRequestCount() {
    Provider.of<CurrentDonorState>(context).getDonorRequests().then(
      (onValue) {
        setState(() {
          pendingRequestCount = onValue.length;
        });
      },
    );
    return pendingCount;
  }

  @override
  Widget build(BuildContext context) {
    _email = Provider.of<CurrentDonorState>(context).getDonorMail();
    _donorCanDonate = Provider.of<CurrentDonorState>(context).getCanDonate();

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
                    'Benvenuto,',
                    style: TextStyle(
                      fontSize: 26,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                ),
                Flexible(
                  child: AutoSizeText(
                    _email,
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
                        backgroundColor: Provider.of<CurrentDonorState>(context)
                                .getCanDonate()
                            ? Colors.green
                            : Colors.red,
                        elevation: 14,
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Provider.of<CurrentDonorState>(context)
                                    .getCanDonate()
                                ? Icons.check
                                : Icons.warning,
                            color: Provider.of<CurrentDonorState>(context)
                                    .getCanDonate()
                                ? Colors.green
                                : Colors.red,
                            size: 18.0,
                          ),
                        ),
                        label: Text(
                          Provider.of<CurrentDonorState>(context).getCanDonate()
                              ? 'Puoi donare'
                              : 'Non puoi donare',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Chip(
                        backgroundColor: Colors.grey[600],
                        elevation: 14,
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.map,
                            color: Colors.grey[600],
                            size: 18,
                          ),
                        ),
                        label: Text(
                          'Il tuo centro AVIS',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Center(
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    top: (MediaQuery.of(context).size.height / 4),
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
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Chip(
                                          avatar: CircleAvatar(
                                            backgroundColor:
                                                Colors.grey.shade800,
                                            child: Icon(
                                              Icons.calendar_today,
                                              size: 14,
                                              color: Colors.white,
                                            ),
                                          ),
                                          label: Text('12 Dicembre 2019'),
                                        ),
                                        CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.grey.shade800,
                                          child: Icon(
                                            Icons.file_download,
                                            size: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    PieChart(
                                      PieChartData(
                                        pieTouchData: PieTouchData(
                                          touchCallback: (pieTouchResponse) {
                                            setState(() {
                                              if (pieTouchResponse.touchInput
                                                      is FlLongPressEnd ||
                                                  pieTouchResponse.touchInput
                                                      is FlPanEnd) {
                                                touchedIndex = -1;
                                                showLegend = true;
                                              } else {
                                                touchedIndex = pieTouchResponse
                                                    .touchedSectionIndex;
                                                showLegend = false;
                                              }
                                            });
                                          },
                                        ),
                                        borderData: FlBorderData(
                                          show: false,
                                        ),
                                        sectionsSpace: 5,
                                        centerSpaceRadius: 60,
                                        sections: showingSections(),
                                      ),
                                    ),
                                    showLegend
                                        ? buildLegend()
                                        : InfoValueBlood(
                                            value: 1,
                                            indexValue: touchedIndex,
                                          )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: 10,
                        itemWidth: 330.0,
                        itemHeight: (MediaQuery.of(context).size.height / 1.7),
                        layout: SwiperLayout.STACK,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: ButtonFABHomePage(
        iconFab: iconFAB(),
      ),
    );
  }

  Column buildLegend() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.red,
              ),
              backgroundColor: Colors.red.withOpacity(0.3),
              label: Text(
                'Globuli rossi',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              backgroundColor: Colors.grey.withOpacity(0.3),
              label: Text(
                'Globuli bianchi',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.orange,
              ),
              backgroundColor: Colors.orange.withOpacity(0.3),
              label: Text(
                'Piastrine',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.green,
              ),
              backgroundColor: Colors.green.withOpacity(0.3),
              label: Text(
                'Colesterolo',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: 40,
            showTitle: false,
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: 30,
            showTitle: false,
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.grey,
            value: 15,
            showTitle: false,
            radius: radius,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            showTitle: false,
            radius: radius,
          );
        default:
          return null;
      }
    });
  }

  List<SpeedDialChild> iconFAB() {
    return <SpeedDialChild>[
      SpeedDialChild(
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/donor/candonate',
          );
        },
        label: 'Possibilità di donare',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      SpeedDialChild(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: 'Richiesta di donazione',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        onTap: () {
          if (_donorCanDonate) {
            Navigator.pushNamed(
              context,
              '/donor/officerequest',
            );
          } else {
            Provider.of<AppState>(context).showFlushbar(
                "Operazione non consentita",
                "Al momento non puoi richiedere di prenotare una donazione, prova tra un pò di giorni.",
                false,
                context);
          }
        },
      ),
      SpeedDialChild(
        label: 'Lista di prenotazioni',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        child: Center(
          child: Badge(
            toAnimate: false,
            showBadge: getPrenotationCount() > 0 ? true : false,
            badgeContent: Padding(
              padding: const EdgeInsets.all(1.4),
              child: Text(getPrenotationCount().toString()),
            ),
            position: BadgePosition.topRight(top: -9, right: -2),
            badgeColor: Colors.white,
            child: Icon(
              Icons.receipt,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/donor/prenotationsview',
          );
        },
      ),
      SpeedDialChild(
        label: 'Lista di richieste',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        child: Center(
          child: Badge(
            toAnimate: false,
            showBadge: getPendingRequestCount() > 0 ? true : false,
            badgeContent: Padding(
              padding: const EdgeInsets.all(1.4),
              child: Text(getPendingCount().toString()),
            ),
            position: BadgePosition.topRight(top: -9, right: -2),
            badgeColor: Colors.white,
            child: Icon(
              Icons.calendar_view_day,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/donor/requestsview',
          );
        },
      ),
      SpeedDialChild(
        label: 'Modifiche dall\'ufficio',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        child: Center(
          child: Badge(
            toAnimate: false,
            showBadge: getPendingCount() > 0 ? true : false,
            badgeContent: Padding(
              padding: const EdgeInsets.all(1.4),
              child: Text(getPendingCount().toString()),
            ),
            position: BadgePosition.topRight(top: -9, right: -2),
            badgeColor: Colors.white,
            child: Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/donor/pendingprenotationsview',
          );
        },
      ),
      SpeedDialChild(
        label: 'Profilo',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        child: Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        onTap: () {},
      ),
    ];
  }
}
