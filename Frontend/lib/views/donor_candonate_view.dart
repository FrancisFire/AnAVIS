import 'package:anavis/providers/current_donor_state.dart';
import 'package:anavis/services/donor_service.dart';
import 'package:anavis/views/widgets/painter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorCanDonateView extends StatefulWidget {
  final bool canDonate;
  DonorCanDonateView({@required this.canDonate});
  @override
  _DonorCanDonateViewState createState() => _DonorCanDonateViewState();
}

class _DonorCanDonateViewState extends State<DonorCanDonateView> {
  DonorService _donorService;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _donorService = new DonorService(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildPainter(
        canDonate: widget.canDonate,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        hoverElevation: 22,
        child: Icon(
          Icons.keyboard_arrow_down,
          color: widget.canDonate ? Colors.green : Colors.red,
          size: 42,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class BuildPainter extends StatelessWidget {
  const BuildPainter({
    Key key,
    @required bool canDonate,
  })  : _canDonate = canDonate,
        super(key: key);

  final bool _canDonate;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Painter(
        first: _canDonate ? Colors.green[200] : Colors.red[200],
        second: _canDonate ? Colors.green[300] : Colors.red[300],
        background: _canDonate ? Colors.green : Colors.red,
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AutoSizeText(
              _canDonate ? "Puoi donare!" : "Non puoi donare",
              textAlign: TextAlign.left,
              style: TextStyle(
                backgroundColor:
                    _canDonate ? Colors.green[900] : Colors.red[900],
                color: Colors.white,
                fontSize: 64,
              ),
              maxLines: 1,
            ),
            SizedBox(
              height: 16,
            ),
            AutoSizeText(
              _canDonate
                  ? "Torna alla homepage con il pulsante in basso e richiedi una prenotazione"
                  : "Non ti è possibile donare, torna presto per ricevere eventuali aggiornamenti",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
    );
  }
}
