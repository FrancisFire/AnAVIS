import 'package:anavis/model/app_state.dart';
import 'package:anavis/model/current_office_state.dart';
import 'package:anavis/views/office_view.dart';
import 'package:anavis/widgets/painter.dart';
import 'package:flushbar/flushbar.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flushbar/flushbar_route.dart' as route;

class OfficePrenotationRecap extends StatefulWidget {
  final String donor;
  final String time;
  final String nicerTime;

  OfficePrenotationRecap({
    @required this.donor,
    @required this.time,
    this.nicerTime,
  });

  @override
  _OfficePrenotationRecapState createState() => _OfficePrenotationRecapState();
}

class _OfficePrenotationRecapState extends State<OfficePrenotationRecap> {
  Random rng = new Random();
  String takeDay(String day) =>
      RegExp(r"Data: ?(.+?) ?\| ?Orario: ?\d\d:\d\d").firstMatch(day).group(1);
  String takeHour(String hour) =>
      RegExp(r"Data: ?.+? ?\| ?Orario: ?(\d\d:\d\d)").firstMatch(hour).group(1);

  String dayValue, hourValue;
  Flushbar confirm, decline, err;

  @override
  void initState() {
    super.initState();
    setNicerTime();
  }

  void setNicerTime() {
    setState(() {
      dayValue = this.takeDay(widget.nicerTime);
      hourValue = this.takeHour(widget.nicerTime);
    });
  }

  Future<void> postRequest() async {
    await Provider.of<CurrentOfficeState>(context).sendPrenotation(
        "${widget.donor}@${Provider.of<CurrentOfficeState>(context).getOfficeName()}@${widget.time}-${rng.nextInt(500)}",
        Provider.of<CurrentOfficeState>(context).getOfficeName(),
        widget.donor,
        widget.time);
  }

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
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomPaint(
        painter: Painter(
          background: Colors.white,
          first: Colors.deepOrange,
          second: Colors.redAccent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 76.0,
                  right: 12.0,
                  left: 12.0,
                ),
                child: Card(
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(26.0),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 20.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Conferma della prenotazione',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 42,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                right: 16.0,
                                left: 16.0,
                              ),
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text:
                                      'La donazione verrà effetuata il giorno ',
                                  style: TextStyle(
                                    color: Colors.grey[850],
                                    fontFamily: 'Rubik',
                                    fontSize: 24,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: dayValue,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' alle ore ',
                                    ),
                                    TextSpan(
                                      text: hourValue,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ' per il donatore ',
                                    ),
                                    TextSpan(
                                      text: widget.donor,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text: '.',
                                    ),
                                    TextSpan(
                                      text:
                                          '\n\nSi desidera proseguire con la prenotazione o declinare?',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.grey[700],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ButtonBarTheme(
                        data: ButtonBarThemeData(
                          alignment: MainAxisAlignment.spaceAround,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 10.0,
                          ),
                          child: ButtonBar(
                            children: <Widget>[
                              AvatarGlow(
                                startDelay: Duration(milliseconds: 1000),
                                glowColor: Colors.redAccent,
                                endRadius: 60.0,
                                duration: Duration(milliseconds: 2000),
                                repeat: true,
                                showTwoGlows: true,
                                repeatPauseDuration:
                                    Duration(milliseconds: 100),
                                child: Material(
                                  color: Colors.transparent,
                                  child: FloatingActionButton(
                                    heroTag: "fab_cancel",
                                    backgroundColor: Colors.red,
                                    elevation: 22,
                                    child: Icon(
                                      Icons.clear,
                                      size: 42,
                                    ),
                                    onPressed: () {
                                      decline = new Flushbar(
                                        margin: EdgeInsets.all(8),
                                        borderRadius: 26,
                                        shouldIconPulse: true,
                                        title: "Prenotazione annullata",
                                        icon: Icon(
                                          Icons.clear,
                                          size: 28.0,
                                          color: Colors.red,
                                        ),
                                        message:
                                            "La prenotazione è stata annullata, la preghiamo di contattare i nostri uffici se lo ritiene opportuno",
                                        duration: Duration(
                                          seconds: 6,
                                        ),
                                        isDismissible: true,
                                        dismissDirection:
                                            FlushbarDismissDirection.HORIZONTAL,
                                      );
                                      this.showFlushbar(this.decline);
                                    },
                                  ),
                                ),
                              ),
                              AvatarGlow(
                                startDelay: Duration(milliseconds: 1000),
                                glowColor: Colors.greenAccent,
                                endRadius: 60.0,
                                duration: Duration(milliseconds: 2000),
                                repeat: true,
                                showTwoGlows: true,
                                repeatPauseDuration:
                                    Duration(milliseconds: 100),
                                child: Material(
                                  color: Colors.transparent,
                                  child: FloatingActionButton(
                                    heroTag: "fab_check",
                                    backgroundColor: Colors.green,
                                    elevation: 22,
                                    child: Icon(
                                      Icons.check,
                                      size: 42,
                                    ),
                                    onPressed: () {
                                      this.postRequest().then((_) {
                                        if (Provider.of<CurrentOfficeState>(
                                                context)
                                            .getStatusBody()) {
                                          confirm = new Flushbar(
                                            margin: EdgeInsets.all(8),
                                            shouldIconPulse: true,
                                            borderRadius: 26,
                                            title: "Prenotazione effettuata",
                                            icon: Icon(
                                              Icons.check,
                                              size: 28.0,
                                              color: Colors.green,
                                            ),
                                            message:
                                                "La prenotazione è stata effettuata con successo",
                                            duration: Duration(
                                              seconds: 6,
                                            ),
                                            isDismissible: true,
                                            dismissDirection:
                                                FlushbarDismissDirection
                                                    .HORIZONTAL,
                                          );
                                          this.showFlushbar(this.confirm);
                                        } else {
                                          err = new Flushbar(
                                            margin: EdgeInsets.all(8),
                                            shouldIconPulse: true,
                                            borderRadius: 26,
                                            title: "Impossibile prenotare",
                                            icon: Icon(
                                              Icons.error,
                                              size: 28.0,
                                              color: Colors.red,
                                            ),
                                            message:
                                                "Non è stato possibile effettuare la prenotazione, riprova più tardi",
                                            duration: Duration(
                                              seconds: 6,
                                            ),
                                            isDismissible: true,
                                            dismissDirection:
                                                FlushbarDismissDirection
                                                    .HORIZONTAL,
                                          );
                                          this.showFlushbar(this.err);
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            WaveWidget(
              config: CustomConfig(
                colors: [
                  Colors.red[900],
                  Colors.red[600],
                  Colors.red[400],
                  Colors.red[300],
                ],
                durations: [
                  35000,
                  19440,
                  10800,
                  6000,
                ],
                heightPercentages: [0.20, 0.23, 0.25, 0.50],
                blur: MaskFilter.blur(
                  BlurStyle.solid,
                  12,
                ),
              ),
              waveAmplitude: 0,
              size: Size(double.infinity, 200),
            ),
          ],
        ),
      ),
    );
  }
}
