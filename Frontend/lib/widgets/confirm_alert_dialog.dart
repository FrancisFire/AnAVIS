import 'package:flutter/material.dart';

class ConfirmAlertDialog extends StatelessWidget {
  final Function confirmFunction;
  final Function denyFunction;
  ConfirmAlertDialog({
    @required this.confirmFunction,
    @required this.denyFunction,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(26.0),
        ),
      ),
      content: Text("Confermare la scelta?"),
      actions: <Widget>[
        new FlatButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(26.0),
            ),
          ),
          label: Text("Annulla"),
          icon: Icon(Icons.cancel),
          onPressed: denyFunction,
          color: Colors.red,
        ),
        new FlatButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(26.0),
            ),
          ),
          icon: Icon(Icons.check),
          label: Text("Conferma"),
          onPressed: confirmFunction,
          color: Colors.green,
        ),
      ],
    );
  }
}
