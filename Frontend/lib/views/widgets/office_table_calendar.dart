import 'package:anavis/views/widgets/remove_glow.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class OfficeTableCalendar extends StatefulWidget {
  final Map<DateTime, List> events;
  OfficeTableCalendar({@required this.events});
  @override
  _OfficeTableCalendarState createState() => _OfficeTableCalendarState();
}

class _OfficeTableCalendarState extends State<OfficeTableCalendar>
    with TickerProviderStateMixin {
  CalendarController _calendarController;
  AnimationController _animationController;
  List _selectedEvents;

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
          title: Text("Non sono presenti prenotazioni attive"),
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TableCalendar(
          calendarController: _calendarController,
          events: widget.events,
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
            titleTextBuilder: (date, locale) => toBeginningOfSentenceCase(
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
          onDaySelected: (day, events) {
            setState(() {
              _selectedEvents = events;
            });
          },
        ),
        Expanded(
          child: _buildEventList(),
        ),
      ],
    );
  }
}
