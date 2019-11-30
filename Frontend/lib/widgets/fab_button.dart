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

class FABLeftArrow extends StatelessWidget {
  final Function onPressed;
  final String nameOffice;
  FABLeftArrow({
    @required this.onPressed,
    @required this.nameOffice,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: RaisedButton.icon(
          color: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(64.0),
            ),
          ),
          icon: Icon(
            Icons.chevron_left,
            size: 52,
            color: Colors.red,
          ),
          label: Text(
            this.nameOffice,
            style: TextStyle(
              color: Colors.red,
              fontSize: 24,
            ),
          ),
          onPressed: () {
            onPressed();
          },
        ),
      ),
    );
  }
}
