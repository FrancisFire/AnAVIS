import 'package:anavis/models/office.dart';
import 'package:anavis/models/timeslot.dart';
import 'package:anavis/services/office_service.dart';
import 'package:anavis/viewargs/donor_request_recap_args.dart';
import 'package:anavis/views/widgets/donor_request_widget.dart';
import 'package:anavis/views/widgets/fab_button.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'donor_request_office_view.dart';

class DonorRequestTimeView extends StatefulWidget {
  final String office;

  DonorRequestTimeView({@required this.office});

  @override
  _DonorRequestTimeViewState createState() => _DonorRequestTimeViewState();
}

class _DonorRequestTimeViewState extends State<DonorRequestTimeView> {
  String _timeSelected;
  String _timeFormatted;
  List<TimeSlot> _availableTimeTables;
  String _officeName;

  Future<void> initFuture() async {
    await Future.wait([
      this.fetchTimeFromOffice(),
      this.fetchNameFromOffice(),
    ]);
  }

  Future<void> fetchNameFromOffice() async {
    Office office = await OfficeService(context).getOfficeByMail(widget.office);
    _officeName = office.getPlace();
  }

  Future<void> fetchTimeFromOffice() async {
    _availableTimeTables = await OfficeService(context)
        .getAvailableTimeTablesByOffice(widget.office);
  }

  List<DropdownMenuItem> createListItem() {
    this.fetchTimeFromOffice();
    List<DropdownMenuItem> listTimeItem = new List<DropdownMenuItem>();
    for (var slot in _availableTimeTables) {
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.initFuture(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return new RequestCircularLoading();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return new RequestCircularLoading();
          case ConnectionState.done:
            if (snapshot.hasError) return new RequestCircularLoading();

            return Scaffold(
              floatingActionButton: _timeSelected != null
                  ? FABRightArrow(
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/donor/officerequest/recap',
                            arguments: new DonorRequestRecapArgs(
                                this.widget.office,
                                this._timeSelected,
                                this._timeFormatted));
                      },
                    )
                  : FABLeftArrow(
                      nameOffice: this._officeName,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, '/donor/officerequest',
                            arguments: new DonorRequestOfficeView());
                      },
                    ),
              body: BuildDonorRequestWidget(
                fetchItems: createListItem(),
                title: "Orario",
                subtitle:
                    "Di seguito potrai selezionare l'orario in cui desideri effettuare la donazione",
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
                    print(_timeSelected);
                  });
                },
              ),
            );
        }
        return null;
      },
    );
  }
}
