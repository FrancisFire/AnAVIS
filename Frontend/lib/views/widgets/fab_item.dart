import 'package:flutter/material.dart';

class BuildRaisedButtonFAB extends StatelessWidget {
  final Icon icon;
  final Function onPressed;
  BuildRaisedButtonFAB({
    @required this.icon,
    @required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: this.icon,
      onPressed: this.onPressed,
      iconSize: 48.0,
      color: Colors.white,
    );
  }
}
