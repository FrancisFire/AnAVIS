import 'package:flutter/material.dart';

class ButtonForCardBottom extends StatelessWidget {
  final String title;
  final Icon icon;
  final Color color;
  final Function onTap;

  ButtonForCardBottom({
    @required this.title,
    @required this.icon,
    @required this.color,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      label: Text(
        title,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      color: color,
      icon: icon,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      onPressed: onTap,
    );
  }
}
