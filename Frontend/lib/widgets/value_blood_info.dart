import 'package:flutter/material.dart';

class InfoValueBlood extends StatelessWidget {
  final int indexValue;
  final int value;

  InfoValueBlood({
    @required this.indexValue,
    @required this.value,
  });

  String convertIndexToValue(int index) {
    switch (index) {
      case 0:
        return "Globuli rossi";
      case 1:
        return "Piastrine";
      case 2:
        return "Globuli bianchi";
      case 3:
        return "Colesterolo";
      default:
        return "Errore";
    }
  }

  Color convertIndexToColor(int index) {
    switch (index) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 2:
        return Colors.grey;
      case 3:
        return Colors.green;
      default:
        return Colors.deepOrangeAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            child: Icon(
              Icons.bubble_chart,
              color: Colors.white,
              size: 32,
            ),
            backgroundColor: convertIndexToColor(indexValue),
          ),
          title: Text(convertIndexToValue(indexValue)),
          subtitle: Text(
            'La misurazione di tale valore è uguale a: ${this.value}',
          ),
          isThreeLine: true,
        ),
      ],
    );
  }
}
