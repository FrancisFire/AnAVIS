import 'package:flutter/material.dart';

class FABRightArrow extends StatelessWidget {
  final Function onPressed;
  FABRightArrow({@required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      child: Icon(
        Icons.chevron_right,
        size: 40,
      ),
      onPressed: () {
        onPressed();
      },
    );
  }
}
