import 'package:anavis/model/app_state.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'button_card_bottom.dart';

class DeleteDialog extends StatelessWidget {
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
                        Navigator.pop(context);
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
