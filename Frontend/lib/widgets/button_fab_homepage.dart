import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class ButtonFABHomePage extends StatelessWidget {
  final List<SpeedDialChild> iconFab;

  ButtonFABHomePage({
    @required this.iconFab,
  });
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      marginRight: 18,
      marginBottom: 20,
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      visible: true,
      closeManually: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.white,
      overlayOpacity: 0.8,
      backgroundColor: Colors.red,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: iconFab,
    );
  }
}
