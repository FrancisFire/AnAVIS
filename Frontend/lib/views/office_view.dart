import 'package:anavis/providers/app_state.dart';
import 'package:anavis/providers/current_office_state.dart';
import 'package:anavis/widgets/button_fab_homepage.dart';
import 'package:anavis/widgets/clip_path.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

class OfficeView extends StatefulWidget {
  @override
  _OfficeViewState createState() => _OfficeViewState();
}

class _OfficeViewState extends State<OfficeView> {
  String _officeName;

  int prenotationCount = 0;

  DateTime _currentDate = DateTime.now();

  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(
          1000,
        ),
      ),
      border: Border.all(
        color: Colors.orange,
        width: 2.0,
      ),
    ),
    child: Icon(
      Icons.person,
      color: Colors.orange,
    ),
  );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {
      new DateTime(2019, 12, 28): [
        new Event(
          date: new DateTime(2019, 12, 28),
          title: 'Event 1',
          icon: _eventIcon,
          dot: Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            color: Colors.red,
            height: 5.0,
            width: 5.0,
          ),
        ),
        new Event(
          date: new DateTime(2019, 12, 28),
          title: 'Event 2',
          icon: _eventIcon,
        ),
        new Event(
          date: new DateTime(2019, 12, 28),
          title: 'Event 3',
          icon: _eventIcon,
        ),
      ],
    },
  );

  int getPrenotationCount() {
    Provider.of<CurrentOfficeState>(context).getOfficePrenotations().then(
      (onValue) {
        setState(() {
          prenotationCount = onValue.length;
        });
      },
    );
    return prenotationCount;
  }

  int requestCount = 0;

  int getRequestCount() {
    Provider.of<CurrentOfficeState>(context).getOfficeRequests().then(
      (onValue) {
        setState(() {
          requestCount = onValue.length;
        });
      },
    );
    return requestCount;
  }

  @override
  Widget build(BuildContext context) {
    _officeName = Provider.of<CurrentOfficeState>(context).getOfficeName();
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
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height / 3,
              bottom: 64,
              right: 8,
              left: 8,
            ),
            child: Card(
              color: Colors.white,
              elevation: 7,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(26.0),
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: CalendarCarousel(
                          selectedDayBorderColor: Colors.red,
                          selectedDayButtonColor: Colors.red,
                          thisMonthDayBorderColor: Colors.grey,
                          locale: 'it',
                          selectedDateTime: _currentDate,
                          daysTextStyle: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.grey,
                          ),
                          weekendTextStyle: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.redAccent,
                          ),
                          iconColor: Colors.red,
                          headerTextStyle: TextStyle(
                            fontFamily: 'Rubik',
                            fontSize: 32,
                            color: Colors.red,
                          ),
                          markedDatesMap: _markedDateMap,
                          markedDateIconBuilder: (event) {
                            return event.icon;
                          },
                          markedDateShowIcon: true,
                          markedDateIconMaxShown: 2,
                          markedDateCustomShapeBorder: CircleBorder(
                            side: BorderSide(
                              color: Colors.transparent,
                            ),
                          ),
                          markedDateMoreShowTotal: true,
                          daysHaveCircularBorder: null,
                          weekdayTextStyle: TextStyle(
                            fontFamily: 'Rubik',
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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

  List<SpeedDialChild> iconFAB() {
    return <SpeedDialChild>[
      SpeedDialChild(
        child: Center(
          child: Badge(
            toAnimate: false,
            showBadge: getRequestCount() > 0 ? true : false,
            badgeContent: Padding(
              padding: const EdgeInsets.all(1.4),
              child: Text(getRequestCount().toString()),
            ),
            position: BadgePosition.topRight(top: -9, right: -2),
            badgeColor: Colors.white,
            child: Icon(
              Icons.featured_play_list,
              color: Colors.white,
            ),
          ),
        ),
        label: 'Richieste presenti',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/office/requests',
            arguments: _officeName,
          );
        },
      ),
      SpeedDialChild(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: 'Aggiungi prenotazione',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        onTap: () async {
          await Provider.of<AppState>(context)
              .setAvailableDonorsByOffice(_officeName);
          if (Provider.of<AppState>(context)
              .getAvailableDonorsByOffice()
              .isEmpty) {
            Provider.of<AppState>(context).showFlushbar(
              'Nessun donatore',
              'Al momento non ci sono donatori disponibili',
              false,
              context,
            );
          } else {
            Navigator.pushNamed(
              context,
              '/office/prenotations',
              arguments: _officeName,
            );
          }
        },
      ),
      SpeedDialChild(
        child: Icon(
          Icons.calendar_today,
          color: Colors.white,
        ),
        label: 'Inserisci giorni e orari',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/office/insertdateslotview',
          );
        },
      ),
      SpeedDialChild(
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
        label: 'Prenotazioni',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/office/prenotationsview',
          );
        },
      ),
      SpeedDialChild(
        child: Icon(
          Icons.location_city,
          color: Colors.white,
        ),
        label: 'Profilo',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        onTap: () {},
      ),
    ];
  }
}
