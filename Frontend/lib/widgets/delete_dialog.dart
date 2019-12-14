import 'package:anavis/models/app_state.dart';
import 'package:anavis/models/current_donor_state.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'button_card_bottom.dart';
import 'package:flushbar/flushbar_route.dart' as route;

class DeleteDialog extends StatelessWidget {
  final String prenotationId;
  DeleteDialog({@required this.prenotationId});
  Future showFlushbar(Flushbar instance, BuildContext context) {
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

  Future<void> _removePrenotation(
      String prenotationId, BuildContext context) async {
    return await Provider.of<CurrentDonorState>(context)
        .removePrenotationByID(prenotationId);
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
                  "Cancella prenotazione",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  "Vuoi seriamente eliminare la tua prenotazione?",
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
                        Navigator.pop(context);
                        Provider.of<AppState>(context).showFlushbar(
                          "Operazione annullata",
                          "L'operazione di rimozione della prenotazione è stata annullata",
                          false,
                          context,
                        );
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
                        this
                            ._removePrenotation(prenotationId, context)
                            .then((_) {
                          if (Provider.of<CurrentDonorState>(context)
                              .getStatusBody()) {
                            var confirm = new Flushbar(
                              margin: EdgeInsets.all(8),
                              shouldIconPulse: true,
                              borderRadius: 26,
                              title: "Prenotazione eliminata",
                              icon: Icon(
                                Icons.check,
                                size: 28.0,
                                color: Colors.green,
                              ),
                              message:
                                  "La prenotazione è stata annullata con successo!",
                              duration: Duration(
                                seconds: 6,
                              ),
                              isDismissible: true,
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                            );
                            this.showFlushbar(confirm, context);
                          } else {
                            var err = new Flushbar(
                              margin: EdgeInsets.all(8),
                              shouldIconPulse: true,
                              borderRadius: 26,
                              title: "Impossibile annullare",
                              icon: Icon(
                                Icons.error,
                                size: 28.0,
                                color: Colors.red,
                              ),
                              message:
                                  "Non è stato possibile annullare la prenotazione, riprova più tardi",
                              duration: Duration(
                                seconds: 6,
                              ),
                              isDismissible: true,
                              dismissDirection:
                                  FlushbarDismissDirection.HORIZONTAL,
                            );
                            this.showFlushbar(err, context);
                          }
                        });
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
