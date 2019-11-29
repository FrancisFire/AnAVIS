import 'package:anavis/model/app_state.dart';
import 'package:anavis/views/donor_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class DonorRequestRecap extends StatefulWidget {
  final String office;
  final String time;
  final String nicerTime;

  DonorRequestRecap({
    @required this.office,
    @required this.time,
    this.nicerTime,
  });

  @override
  _DonorRequestRecapState createState() => _DonorRequestRecapState();
}

class _DonorRequestRecapState extends State<DonorRequestRecap> {
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

  void postRequest() {
    Provider.of<AppState>(context)
        .sendRequest("1", widget.office, "stelluti@mail.com", widget.time);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                                text: 'La donazione verrà effetuata il giorno ',
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
                            FloatingActionButton(
                              heroTag: "fab_cancel",
                              backgroundColor: Colors.red,
                              elevation: 22,
                              child: Icon(
                                Icons.clear,
                                size: 42,
                              ),
                              onPressed: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DonorView();
                                }));
                              },
                            ),
                            FloatingActionButton(
                              heroTag: "fab_check",
                              backgroundColor: Colors.green,
                              elevation: 22,
                              child: Icon(
                                Icons.check,
                                size: 42,
                              ),
                              onPressed: () {
                                this.postRequest();
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return DonorView();
                                }));
                              },
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
    );
  }
}
