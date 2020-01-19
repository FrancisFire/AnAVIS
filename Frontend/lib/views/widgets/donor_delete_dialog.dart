import 'package:anavis/services/prenotation_service.dart';
import 'package:anavis/services/request_service.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'button_card_bottom.dart';

class DonorDeleteDialog extends StatefulWidget {
  final String id;
  final String title;
  final String subtitle;
  final bool isPrenotation;
  DonorDeleteDialog({
    @required this.id,
    @required this.title,
    @required this.subtitle,
    @required this.isPrenotation,
  });

  @override
  _DonorDeleteDialogState createState() => _DonorDeleteDialogState();
}

class _DonorDeleteDialogState extends State<DonorDeleteDialog> {
  Function removePrenotationFunction(BuildContext context) {
    PrenotationService(context).removePrenotation(widget.id).then((status) {
      if (status) {
        Navigator.popUntil(context, ModalRoute.withName('DonorView'));
        new ConfirmationFlushbar("Prenotazione eliminata",
                "La prenotazione è stata annullata con successo!", true)
            .show(context);
      } else {
        Navigator.popUntil(context, ModalRoute.withName('DonorView'));
        new ConfirmationFlushbar(
                "Impossibile annullare",
                "Non è stato possibile annullare la prenotazione, riprova più tardi",
                true)
            .show(context);
      }
    });
  }

  Function removeRequestFunction(BuildContext context) {
    RequestService(context).denyRequest(widget.id).then((status) {
      if (status) {
        Navigator.popUntil(context, ModalRoute.withName('DonorView'));
        new ConfirmationFlushbar("Richiesta eliminata",
                "La richiesta è stata annullata con successo!", true)
            .show(context);
      } else {
        Navigator.popUntil(context, ModalRoute.withName('DonorView'));
        new ConfirmationFlushbar(
                "Impossibile annullare",
                "Non è stato possibile annullare la prenotazione, riprova più tardi",
                false)
            .show(context);
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  this.widget.title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  this.widget.subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[850],
                    fontFamily: 'Rubik',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 24.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ButtonForCardBottom(
                      icon: Icon(
                        Icons.thumb_down,
                        color: Colors.white,
                      ),
                      color: Colors.red,
                      onTap: () {
                        Navigator.popUntil(
                            context, ModalRoute.withName('DonorView'));
                        ConfirmationFlushbar(
                                "Operazione annullata",
                                "L'operazione di rimozione è stata annullata",
                                false)
                            .show(context);
                      },
                      title: 'Annulla',
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    ButtonForCardBottom(
                      icon: Icon(
                        Icons.thumb_up,
                        color: Colors.white,
                      ),
                      color: Colors.green,
                      onTap: () {
                        this.widget.isPrenotation
                            ? removePrenotationFunction(context)
                            : removeRequestFunction(context);
                      },
                      title: 'Conferma',
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: Consts.padding,
            right: Consts.padding,
            child: Container(
              transform: Matrix4.translationValues(
                  0.0, -Consts.avatarRadius + Consts.padding, 0.0),
              child: CircleAvatar(
                backgroundColor: Colors.red[600],
                foregroundColor: Colors.white,
                radius: Consts.avatarRadius,
                child: FlareActor(
                  "assets/general/sad.flr",
                  alignment: Alignment.center,
                  fit: BoxFit.contain,
                  animation: "crying",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 36.0;
}
