import 'dart:io';

import 'package:anavis/models/activeprenotation.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/providers/current_donor_state.dart';
import 'package:anavis/providers/current_office_state.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDialogUploadFile extends StatefulWidget {
  final ActivePrenotation prenotation;

  CustomDialogUploadFile({
    @required this.prenotation,
  });

  @override
  _CustomDialogUploadFileState createState() => _CustomDialogUploadFileState();
}

class _CustomDialogUploadFileState extends State<CustomDialogUploadFile> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      child: dialogContent(context),
    );
  }

  dialogContent(BuildContext context) {
    return Stack(
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
                "Inserisci referto",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey[850],
                    fontFamily: 'Rubik',
                    fontSize: 16,
                  ),
                  text:
                      "Mediante la seguente form si potrà fare l'upload di un file relativo al referto",
                ),
              ),
              SizedBox(height: 24.0),
              RaisedButton.icon(
                icon: Icon(
                  Icons.file_upload,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                ),
                onPressed: () async {
                  _closePrenotation(widget.prenotation.getId()).then((_) {
                    if (Provider.of<CurrentOfficeState>(context)
                        .getStatusBody()) {
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Provider.of<AppState>(context).showFlushbar(
                        "Operazione confermata",
                        "L'operazione di upload è stata effettuata con successo e la chiusura della prenotazione chiusa",
                        true,
                        context,
                      );
                    } else {
                      Provider.of<AppState>(context).showFlushbar(
                        "Operazione non riuscita",
                        "L'operazione di upload è stata annullata e di consegunza la chiusura della prenotazione non è riuscita",
                        false,
                        context,
                      );
                    }
                  });
                },
                label: Text(
                  "Seleziona il file",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                color: Colors.indigo,
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
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue[200],
              radius: Consts.avatarRadius,
              child: FlareActor(
                "assets/general/upload.flr",
                alignment: Alignment.center,
                fit: BoxFit.contain,
                animation: "go",
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _closePrenotation(String id) async {
    File file = await FilePicker.getFile(type: FileType.ANY);
    await Provider.of<CurrentOfficeState>(context).closePrenotation(id, file);
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 52.0;
}
