import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class RequestCircularLoading extends StatelessWidget {
  const RequestCircularLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.redAccent,
        child: Stack(
          children: <Widget>[
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
              size: Size(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height),
            ),
            Positioned(
              right: 24,
              left: 24,
              top: MediaQuery.of(context).size.height / 2.5,
              child: Center(
                child: Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(18.0),
                    ),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: Icon(
                      Icons.cached,
                      size: 32,
                      color: Colors.red,
                    ),
                    title: Text(
                      "Caricamento in corso",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      "Si prega di attendere il completamento del caricamento della pagina",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
