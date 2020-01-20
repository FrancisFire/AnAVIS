import 'package:anavis/models/donor.dart';
import 'package:anavis/views/widgets/message_painter.dart';
import 'package:flutter/material.dart';

class DonorCanDonateView extends StatefulWidget {
  final Donor donor;
  DonorCanDonateView({@required this.donor});
  @override
  _DonorCanDonateViewState createState() => _DonorCanDonateViewState();
}

class _DonorCanDonateViewState extends State<DonorCanDonateView> {
  @override
  Widget build(BuildContext context) {
    return MessagePainter(
      isGood: widget.donor.canDonate(),
      positiveTitle: "Puoi donare!",
      negativeTitle: "Non puoi donare",
      positiveMsg:
          "Torna alla homepage con il pulsante in basso e richiedi una prenotazione",
      negativeMsg:
          "Non ti è possibile donare, torna presto per ricevere eventuali aggiornamenti",
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}
