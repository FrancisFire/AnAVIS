import 'package:anavis/models/activeprenotation.dart';
import 'package:anavis/models/office.dart';
import 'package:anavis/models/requestprenotation.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/services/office_service.dart';
import 'package:anavis/services/prenotation_service.dart';
import 'package:anavis/services/request_service.dart';
import 'package:anavis/views/widgets/button_fab_homepage.dart';
import 'package:anavis/views/widgets/clip_path.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:anavis/views/widgets/office_table_calendar.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:badges/badges.dart';

class OfficeView extends StatefulWidget {
  @override
  _OfficeViewState createState() => _OfficeViewState();
}

class _OfficeViewState extends State<OfficeView> with TickerProviderStateMixin {
  Office _office;
  int prenotationCount = 0;
  int pendingRequestCount = 0;
  bool state = false;
  Map<DateTime, List> _nicerEvents;

  Future<void> setOffice() async {
    this._office =
        await OfficeService(context).getOfficeByMail(AppState().getUserMail());
  }

  Future<void> initFuture() async {
    await this.setOffice();
    print("Ufficio ${this._office}");
    await Future.wait([
      this.setPrenotationsCount(),
      this.setRequestsCount(),
      this.fetchEvents(),
    ]);
  }

  Future<void> fetchEvents() async {
    _nicerEvents = new Map<DateTime, List>();
    List<ActivePrenotation> prenotations = await PrenotationService(context)
        .getPrenotationsByOffice(this._office.getMail());
    for (var activePrenotation in prenotations) {
      if (activePrenotation.isConfirmed()) {
        _nicerEvents.putIfAbsent(DateTime.parse(activePrenotation.getHour()),
            () => [activePrenotation.getDonorMail()]);
      }
    }
  }

  Future<void> setPrenotationsCount() async {
    List<ActivePrenotation> activePrenotations =
        await PrenotationService(context)
            .getPrenotationsByOffice(_office.getMail());
    prenotationCount = activePrenotations.length;
  }

  Future<void> setRequestsCount() async {
    List<RequestPrenotation> requests =
        await RequestService(context).getRequestsByOffice(_office.getMail());
    pendingRequestCount = requests.length;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return FutureBuilder(
      future: this.initFuture(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new RequestCircularLoading();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return new RequestCircularLoading();
          case ConnectionState.done:
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
                    padding:
                        const EdgeInsets.only(top: 46, left: 16, right: 16),
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
                            this._office.getPlace(),
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
                            child: OfficeTableCalendar(
                              events: this._nicerEvents,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: ButtonFABHomePage(
                iconFab: iconFAB(),
              ),
            );
            return null;
        }
      },
    );
  }

  List<SpeedDialChild> iconFAB() {
    return <SpeedDialChild>[
      SpeedDialChild(
        child: Center(
          child: Badge(
            toAnimate: false,
            showBadge: this.pendingRequestCount > 0 ? true : false,
            badgeContent: Padding(
              padding: const EdgeInsets.all(1.4),
              child: Text(this.pendingRequestCount.toString()),
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
            arguments: this._office,
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
          Navigator.pushNamed(
            context,
            '/office/prenotations',
            arguments: this._office,
          );
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
            arguments: this._office,
          );
        },
      ),
      SpeedDialChild(
        child: Center(
          child: Badge(
            toAnimate: false,
            showBadge: this.prenotationCount > 0 ? true : false,
            badgeContent: Padding(
              padding: const EdgeInsets.all(1.4),
              child: Text(this.prenotationCount.toString()),
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
            arguments: this._office,
          );
        },
      ),
      SpeedDialChild(
        label: 'Logout',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        child: Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        onTap: () {
          AppState().logout();
          Navigator.pushReplacementNamed(
            context,
            '/',
          );
        },
      ),
    ];
  }
}
