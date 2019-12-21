import 'package:anavis/providers/current_office_state.dart';
import 'package:anavis/viewargs/office_prenotation_recap_args.dart';
import 'package:anavis/widgets/donor_request_widget.dart';
import 'package:anavis/widgets/fab_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

// /office/prenotations/timeview

class OfficePrenotationTimeView extends StatefulWidget {
  final String officeName;
  final String donor;

  OfficePrenotationTimeView({
    @required this.officeName,
    @required this.donor,
  });

  @override
  _OfficePrenotationTimeViewState createState() =>
      _OfficePrenotationTimeViewState();
}

class _OfficePrenotationTimeViewState extends State<OfficePrenotationTimeView> {
  String _timeSelected;
  String _timeFormatted;

  void fetchTimeFromOffice() async {
    await Provider.of<CurrentOfficeState>(context).setOfficeTimeTables();
  }

  List<DropdownMenuItem> createListItem() {
    this.fetchTimeFromOffice();
    List<DropdownMenuItem> listTimeItem = new List<DropdownMenuItem>();
    for (var slot
        in Provider.of<CurrentOfficeState>(context).getAvailableTimeTables()) {
      String restrictFractionalSeconds(String dateTime) =>
          dateTime.replaceFirstMapped(RegExp(r"(\.\d{6})\d+"), (m) => m[1]);
      _timeFormatted = formatDate(
          DateTime.parse(restrictFractionalSeconds(slot.getDateTime())),
          ["Data: ", dd, '-', mm, '-', yyyy, " | Orario: ", HH, ":", nn]);

      listTimeItem.add(new DropdownMenuItem(
        value: slot.getDateTime(),
        child: Container(
          child: Text(
            _timeFormatted,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ));
    }
    return listTimeItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _timeSelected != null
          ? FABRightArrow(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, '/office/prenotations/recap',
                    arguments: new OfficePrenotationRecapArgs(this.widget.donor,
                        this._timeSelected, this._timeFormatted));
              },
            )
          : FABLeftArrow(
              nameOffice: widget.donor
                  .split('@')
                  .map((String text) => text)
                  .elementAt(0),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
      backgroundColor: Colors.white,
      body: BuildDonorRequestWidget(
        fetchItems: createListItem(),
        title: "Orario",
        subtitle:
            "Di seguito potrai selezionare l'orario in cui si vorrebbe far donare l'utente scelto",
        icon: Icon(
          Icons.access_time,
          size: 42,
          color: Colors.red,
        ),
        labelDropDown: "Seleziona l'orario",
        valueSelected: _timeSelected,
        onChanged: (newValue) {
          setState(() {
            _timeSelected = newValue;
          });
        },
      ),
    );
  }
}
