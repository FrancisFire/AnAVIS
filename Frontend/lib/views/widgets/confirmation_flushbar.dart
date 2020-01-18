import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ConfirmationFlushbar {
  String _title;
  String _message;
  bool _isGood;
  Flushbar _source;
  ConfirmationFlushbar(String title, String message, bool isGood) {
    this._title = title;
    this._message = message;
    this._isGood = isGood;
    _source = new Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: 26,
      shouldIconPulse: true,
      title: _title,
      icon: _isGood
          ? Icon(
              Icons.check,
              size: 28.0,
              color: Colors.green[600],
            )
          : Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.red[600],
            ),
      message: _message,
      duration: Duration(
        seconds: 6,
      ),
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    );
  }

  Future<Object> show(BuildContext context) {
    return _source.show(context);
  }
}
