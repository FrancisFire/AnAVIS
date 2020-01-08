import 'package:anavis/models/timeslot.dart';
import 'package:anavis/providers/current_office_state.dart';
import 'package:anavis/widgets/painter.dart';
import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:intl/intl.dart';
import 'package:flushbar/flushbar_route.dart' as route;

class OfficeAddDateslotView extends StatefulWidget {
  @override
  _OfficeAddDateslotViewState createState() => _OfficeAddDateslotViewState();
}

class _OfficeAddDateslotViewState extends State<OfficeAddDateslotView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: CustomPaint(
          painter: Painter(
            first: Colors.red[100],
            second: Colors.orange[200],
            background: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: ListView(
                children: <Widget>[
                  SlimyCard(
                    color: Colors.red,
                    width: MediaQuery.of(context).size.width / 1.2,
                    topCardHeight: MediaQuery.of(context).size.height / 4,
                    bottomCardHeight: MediaQuery.of(context).size.height / 1.8,
                    borderRadius: 16,
                    topCardWidget: TopCardWidget(),
                    bottomCardWidget: BottomCardWidget(),
                    slimeEnabled: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomCardWidget extends StatefulWidget {
  @override
  _BottomCardWidgetState createState() => _BottomCardWidgetState();
}

class _BottomCardWidgetState extends State<BottomCardWidget> {
  final format = DateFormat("yyyy-MM-dd HH:mm");

  int numberValue;
  DateTime dateValue;

  Future<void> addTimeTableSlot() async {
    await Provider.of<CurrentOfficeState>(context)
        .addTimeTableSlot(new TimeSlot(
      formatDate(dateValue, [
        '20',
        yy,
        '-',
        mm,
        '-',
        dd,
        'T',
        HH,
        ':',
        nn,
        ':',
        ss,
        '.000+0000',
      ]),
      numberValue,
    ));
  }

  Flushbar confirm, err, nullValues;

  Future showFlushbar(Flushbar instance) {
    final _route = route.showFlushbar(
      context: context,
      flushbar: instance,
    );

    return Navigator.of(
      context,
      rootNavigator: false,
    ).pushReplacement(
      _route,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Seleziona una data',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          DateTimeField(
            format: format,
            decoration: InputDecoration(
              filled: true,
              labelText: "Inserisci una data",
              fillColor: Colors.white,
              icon: Icon(
                Icons.calendar_today,
                color: Colors.white,
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    24.0,
                  ),
                ),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            onShowPicker: (context, currentValue) async {
              final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime.now() ?? currentValue,
                  initialDate: currentValue ?? DateTime.now(),
                  lastDate: DateTime(2100));
              if (date != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime:
                      TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                );
                dateValue = DateTimeField.combine(date, time);
                return DateTimeField.combine(date, time);
              } else {
                dateValue = currentValue;
                return currentValue;
              }
            },
          ),
          Text(
            'Seleziona una numero di prenotazioni',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          DropdownButtonFormField<int>(
            value: numberValue,
            decoration: InputDecoration(
              filled: true,
              labelText: "Inserisci un valore",
              fillColor: Colors.white,
              icon: Icon(
                Icons.format_list_numbered,
                color: Colors.white,
              ),
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    24.0,
                  ),
                ),
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
            ),
            items: List<int>.generate(25, (i) => i + 1).map((int value) {
              return new DropdownMenuItem<int>(
                value: value,
                child: new Text(
                  value.toString(),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                numberValue = newValue;
              });
            },
          ),
          Center(
            child: FlatButton.icon(
              color: Colors.orangeAccent,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16.0),
                ),
              ),
              icon: Icon(
                Icons.control_point,
                color: Colors.white,
              ),
              label: Text(
                "Conferma l'inserimento",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (dateValue == null || numberValue == null) {
                  nullValues = new Flushbar(
                    margin: EdgeInsets.all(8),
                    shouldIconPulse: true,
                    borderRadius: 26,
                    title: "Valori nulli",
                    icon: Icon(
                      Icons.warning,
                      size: 28.0,
                      color: Colors.orangeAccent,
                    ),
                    message:
                        "Non è stata confermata nessuna prenotazione in quanto i valori inseriti erano nulli",
                    duration: Duration(
                      seconds: 4,
                    ),
                    isDismissible: true,
                    dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                  );
                  this.showFlushbar(this.nullValues);
                }
                this.addTimeTableSlot().then((_) {
                  if (Provider.of<CurrentOfficeState>(context)
                      .getStatusBody()) {
                    confirm = new Flushbar(
                      margin: EdgeInsets.all(8),
                      shouldIconPulse: true,
                      borderRadius: 26,
                      title: "Inserimento confermato",
                      icon: Icon(
                        Icons.check,
                        size: 28.0,
                        color: Colors.green,
                      ),
                      message:
                          "La nuova possibilità di prenotazione è stata creata con successo e sarà visualizzabile a breve dai donatori",
                      duration: Duration(
                        seconds: 5,
                      ),
                      isDismissible: true,
                      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                    );
                    this.showFlushbar(this.confirm);
                  } else {
                    err = new Flushbar(
                      margin: EdgeInsets.all(8),
                      shouldIconPulse: true,
                      borderRadius: 26,
                      title: "Impossibile inserire",
                      icon: Icon(
                        Icons.error,
                        size: 28.0,
                        color: Colors.red,
                      ),
                      message:
                          "Non è stato possibile effettuare l'inserimento, si prega di riprovare più tardi",
                      duration: Duration(
                        seconds: 4,
                      ),
                      isDismissible: true,
                      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                    );
                    this.showFlushbar(this.err);
                  }
                });
              },
            ),
          )
        ],
      ),
    );
  }
}

class TopCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            child: ListTile(
              title: Text(
                "Inserisci una data",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              isThreeLine: true,
              contentPadding: const EdgeInsets.all(14.0),
              dense: false,
              subtitle: Text(
                'Seleziona una data e un numero di prenotazioni per il quale desideri creare delle potenziali richieste, per l\'ufficio corrente, che i donatori potranno vedere',
                style: TextStyle(
                  color: Colors.grey[200],
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
