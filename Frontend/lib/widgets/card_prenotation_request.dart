import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class CardForPrenotationAndRequest extends StatelessWidget {
  final String id;
  final String email;
  final String hour;
  final ButtonBar buttonBar;

  CardForPrenotationAndRequest({
    @required this.id,
    @required this.email,
    @required this.hour,
    @required this.buttonBar,
  });

  static String restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp(r"(\.\d{6})\d+"), (m) => m[1]);

  static String nicerTime(String timeNotNice) {
    return formatDate(DateTime.parse(restrictFractionalSeconds(timeNotNice)),
        ["Data: ", dd, '-', mm, '-', yyyy, " | Orario: ", HH, ":", nn]);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 3,
      ),
      child: Card(
        color: Colors.white,
        elevation: 12,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(26.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.red[600],
                child: Text(
                  email.toString().substring(0, 1).toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              title: Text(
                email,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
              subtitle: Text(
                nicerTime(hour),
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ),
            buttonBar,
          ],
        ),
      ),
    );
  }
}
