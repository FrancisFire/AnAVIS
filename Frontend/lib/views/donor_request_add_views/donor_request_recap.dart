import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class DonorRequestRecap extends StatefulWidget {
  final String office;
  final String time;

  DonorRequestRecap({@required this.office, @required this.time});

  @override
  _DonorRequestRecapState createState() => _DonorRequestRecapState();
}

class _DonorRequestRecapState extends State<DonorRequestRecap> {
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
                top: 56.0,
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
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        'Ciccio',
                        textAlign: TextAlign.center,
                      ),
                      subtitle: Text(
                        'Music by Julie Gable. Lyrics by Sidney Stein.',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ButtonBarTheme(
                      data: ButtonBarThemeData(
                        alignment: MainAxisAlignment.spaceAround,
                      ),
                      // make buttons use the appropriate styles for cards
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('BUY TICKETS'),
                            onPressed: () {/* ... */},
                          ),
                          FlatButton(
                            child: const Text('LISTEN'),
                            onPressed: () {/* ... */},
                          ),
                        ],
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
