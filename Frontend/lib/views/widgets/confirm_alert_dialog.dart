import 'package:flutter/material.dart';

class ConfirmAlertDialog extends StatelessWidget {
  final Function confirmFunction;
  final Function denyFunction;
  final String confirmText;
  final String denyText;
  final String question;
  ConfirmAlertDialog({
    @required this.confirmFunction,
    @required this.denyFunction,
    @required this.confirmText,
    @required this.denyText,
    @required this.question,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(26.0),
        ),
      ),
      content: Text(question),
      actions: <Widget>[
        new FlatButton.icon(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(26.0),
            ),
          ),
          label: Text(denyText),
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
          label: Text(confirmText),
          onPressed: confirmFunction,
          color: Colors.green,
        ),
      ],
    );
  }
}
