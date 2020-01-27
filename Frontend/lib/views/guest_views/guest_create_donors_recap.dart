import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/services/authcredentials_service.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/painter.dart';
import 'package:flutter/services.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class GuestCreateDonorRecap extends StatefulWidget {
  final AuthCredentials credentials;
  final Donor donor;
  GuestCreateDonorRecap({
    @required this.credentials,
    @required this.donor,
  });

  @override
  _GuestCreateDonorRecapState createState() => _GuestCreateDonorRecapState();
}

class _GuestCreateDonorRecapState extends State<GuestCreateDonorRecap> {
  Future<bool> postRequest() async {
    bool confirmation = await AuthCredentialsService(context)
        .addDonorCredentials(widget.donor, widget.credentials);
    return confirmation;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: CustomPaint(
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
                                'Conferma della registrazione',
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
                                    text: 'La registrazione per l\'utente ',
                                    style: TextStyle(
                                      color: Colors.grey[850],
                                      fontFamily: 'Rubik',
                                      fontSize: 24,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: widget.credentials.getMail(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' con la password ',
                                      ),
                                      TextSpan(
                                        text: widget.credentials.getPassword(),
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' per il donatore ',
                                      ),
                                      TextSpan(
                                        text: widget.donor.getName() +
                                            " " +
                                            widget.donor.getSurname(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '.',
                                      ),
                                      TextSpan(
                                        text:
                                            '\n\nSi desidera proseguire con la registrazione o annullare?',
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
                                        Navigator.pushReplacementNamed(
                                          context,
                                          '/',
                                        );
                                        new ConfirmationFlushbar(
                                          "Registrazione annullata",
                                          "La richiesta è stata annullata, la preghiamo di contattare i nostri uffici se lo ritiene opportuno",
                                          false,
                                        ).show(context);
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
                                        this.postRequest().then((status) {
                                          if (status) {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              '/',
                                            );
                                            new ConfirmationFlushbar(
                                                    "Registrazione effettuata",
                                                    "L'utente può ora autenticarsi al servizio",
                                                    true)
                                                .show(context);
                                          } else {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              '/',
                                            );
                                            new ConfirmationFlushbar(
                                                    "Errore nella registrazione",
                                                    "Non è stato possibile registrare l'utente",
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
