import 'package:anavis/services/prenotation_service.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/painter.dart';
import 'package:flutter/services.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DonorPrenotationUpdateRecap extends StatefulWidget {
  final String office;
  final String time;
  final String nicerTime;
  final String prenotationId;
  DonorPrenotationUpdateRecap({
    @required this.office,
    @required this.time,
    this.nicerTime,
    @required this.prenotationId,
  });

  @override
  _DonorPrenotationUpdateRecapState createState() =>
      _DonorPrenotationUpdateRecapState();
}

class _DonorPrenotationUpdateRecapState
    extends State<DonorPrenotationUpdateRecap> {
  Random rng = new Random();
  String takeDay(String day) =>
      RegExp(r"Data: ?(.+?) ?\| ?Orario: ?\d\d:\d\d").firstMatch(day).group(1);
  String takeHour(String hour) =>
      RegExp(r"Data: ?.+? ?\| ?Orario: ?(\d\d:\d\d)").firstMatch(hour).group(1);

  String dayValue, hourValue;

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
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
                                'Conferma della nuova prenotazione',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
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
                                        'La donazione verrà effettuata il giorno ',
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
                                        text: ' nell\'ufficio di ',
                                      ),
                                      TextSpan(
                                        text: widget.office,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '.',
                                      ),
                                      TextSpan(
                                        text:
                                            '\n\nSi desidera proseguire con la richiesta o declinare?',
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
                                        PrenotationService(context)
                                            .denyPrenotationChange(
                                                widget.prenotationId)
                                            .then((status) {
                                          if (status) {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'DonorView'));
                                            new ConfirmationFlushbar(
                                                    "Conferma annullata",
                                                    "La nuova prenotazione è stata annullata con successo",
                                                    true)
                                                .show(context);
                                          } else {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'DonorView'));
                                            new ConfirmationFlushbar(
                                                    "Impossibile confermare",
                                                    "Non è stato possibile effettuare la conferma, riprova più tardi",
                                                    false)
                                                .show(context);
                                          }
                                        });
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
                                        PrenotationService(context)
                                            .acceptPrenotationChange(
                                                widget.prenotationId)
                                            .then((status) {
                                          if (status) {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'DonorView'));
                                            new ConfirmationFlushbar(
                                                    "Conferma effettuata",
                                                    "La conferma della nuova prenotazione è stata effettuata con successo!",
                                                    true)
                                                .show(context);
                                          } else {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'DonorView'));
                                            new ConfirmationFlushbar(
                                                    "Impossibile confermare",
                                                    "Non è stato possibile effettuare la conferma, riprova più tardi",
                                                    false)
                                                .show(context);
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
      ),
    );
  }
}
