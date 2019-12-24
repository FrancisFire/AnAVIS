import 'package:flutter/material.dart';

class OfficeAddDateslotView extends StatefulWidget {
  @override
  _OfficeAddDateslotViewState createState() => _OfficeAddDateslotViewState();
}

class _OfficeAddDateslotViewState extends State<OfficeAddDateslotView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inserisci giorni e orari"),
      ),
      body: Center(
        child: Text(
          "Aggiungi dateslot",
        ),
      ),
    );
  }
}
