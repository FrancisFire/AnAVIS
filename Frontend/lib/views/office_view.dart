import 'package:anavis/apicontrollers/prenotation_controller.dart';
import 'package:anavis/models/activeprenotation.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/providers/current_office_state.dart';
import 'package:anavis/services/donor_service.dart';
import 'package:anavis/services/prenotation_service.dart';
import 'package:anavis/services/request_service.dart';
import 'package:anavis/views/widgets/button_fab_homepage.dart';
import 'package:anavis/views/widgets/clip_path.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/login_form.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class OfficeView extends StatefulWidget {
  @override
  _OfficeViewState createState() => _OfficeViewState();
}

class _OfficeViewState extends State<OfficeView> with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  PrenotationService _prenotationService;
  RequestService _requestService;
  DonorService _donorService;
  String _mail;
  List<Donor> _availableDonors = new List<Donor>();

  bool state = false;

  @override
  void initState() {
    super.initState();
    _prenotationService = new PrenotationService(context);
    _requestService = new RequestService(context);
    _mail = AppState().getUserMail();
    _donorService = new DonorService(context);
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    setState(() {
      _selectedEvents = events;
    });
  }

  Future<void> getAvailableDonors() async {
    _availableDonors =
        await _donorService.getAvailableDonorsByOfficeId(this._mail);
    return;
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {}

  Future<Map<DateTime, List>> _fetchEvents() async {
    Map<DateTime, List> nicerEvents = new Map<DateTime, List>();
    List<ActivePrenotation> prenotations =
        await _prenotationService.getPrenotationsByOffice(this._mail);
    for (var activePrenotation in prenotations) {
      if (activePrenotation.isConfirmed()) {
        nicerEvents.putIfAbsent(DateTime.parse(activePrenotation.getHour()),
            () => [activePrenotation.getDonorMail()]);
      }
    }
    return nicerEvents;
  }

  int prenotationCount = 0;

  int getPrenotationCount() {
    _prenotationService.getPrenotationsByOffice(this._mail).then(
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
    _requestService.getRequestsByOffice(this._mail).then(
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
                    this._mail,
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
                      FutureBuilder(
                        future: _fetchEvents(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 42.0),
                              child: CircularProgressIndicator(),
                            );
                          }

                          return TableCalendar(
                            calendarController: _calendarController,
                            events: snapshot.data,
                            locale: 'it_IT',
                            initialCalendarFormat: CalendarFormat.week,
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Esteso',
                              CalendarFormat.week: 'Ridotto',
                            },
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            calendarStyle: CalendarStyle(
                              selectedColor: Colors.red[800],
                              todayColor: Colors.grey[600],
                              markersColor: Colors.orangeAccent[400],
                              outsideDaysVisible: false,
                            ),
                            initialSelectedDay: DateTime.now(),
                            headerStyle: HeaderStyle(
                              titleTextBuilder: (date, locale) =>
                                  toBeginningOfSentenceCase(
                                DateFormat.yMMMM(locale).format(date),
                              ),
                              formatButtonTextStyle: TextStyle().copyWith(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                              formatButtonDecoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                            ),
                            onDaySelected: _onDaySelected,
                            onVisibleDaysChanged: _onVisibleDaysChanged,
                          );
                        },
                      ),
                      Expanded(
                        child: _buildEventList(),
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

  Widget _buildEventList() {
    if (_selectedEvents == null) {
      return Center(
        child: ListTile(
          title: Text("Seleziona una data"),
          leading: Icon(
            Icons.info,
            size: 36,
          ),
          isThreeLine: true,
          subtitle: Text(
            "Si prega di selezionare una data per visualizzare gli eventi presenti in un determinato giorno",
          ),
        ),
      );
    } else if (_selectedEvents.isNotEmpty) {
      return ScrollConfiguration(
        behavior: RemoveGlow(),
        child: ListView(
          children: _selectedEvents
              .map((event) => Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                    elevation: 6,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.red,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(event.toString()),
                    ),
                  ))
              .toList(),
        ),
      );
    } else {
      return Center(
        child: ListTile(
          title: Text("Non sono presenti donazioni"),
          leading: Icon(
            Icons.sentiment_dissatisfied,
            size: 36,
          ),
          isThreeLine: true,
          subtitle: Text(
            "Inserisci nuove date utili per le donazioni per incentivare le donazioni nell'ufficio locale!",
          ),
        ),
      );
    }
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
            arguments: this._mail,
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
          await this.getAvailableDonors();
          if (this._availableDonors.isEmpty) {
            ConfirmationFlushbar(
              'Nessun donatore',
              'Al momento non ci sono donatori disponibili',
              false,
            ).show(context);
            /* Provider.of<AppState>(context).showFlushbar(
              'Nessun donatore',
              'Al momento non ci sono donatori disponibili',
              false,
              context,
            );*/
          } else {
            Navigator.pushNamed(
              context,
              '/office/prenotations',
              arguments: this._mail,
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
