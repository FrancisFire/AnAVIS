import 'package:anavis/models/timeslot.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/providers/current_office_state.dart';
import 'package:anavis/services/office_service.dart';
import 'package:anavis/viewargs/donor_request_recap_args.dart';
import 'package:anavis/views/widgets/donor_request_widget.dart';
import 'package:anavis/views/widgets/fab_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  List<TimeSlot> _timeTables;
  List<TimeSlot> _availableTimeTables;
  OfficeService _officeService;

  void fetchTimeFromOffice() async {
    _timeTables = await _officeService.getDonationsTimeTable(widget.office);
    _availableTimeTables =
        await _officeService.getAvailableTimeTablesByOffice(widget.office);
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
    // TODO: implement initState
    super.initState();
    _officeService = new OfficeService(context);
    this.fetchTimeFromOffice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _timeSelected != null
          ? FABRightArrow(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, '/donor/officerequest/recap',
                    arguments: new DonorRequestRecapArgs(this.widget.office,
                        this._timeSelected, this._timeFormatted));
              },
            )
          : FABLeftArrow(
              nameOffice: widget.office,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/donor/officerequest',
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
}
