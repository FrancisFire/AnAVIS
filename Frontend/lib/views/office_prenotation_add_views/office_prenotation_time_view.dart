import 'package:anavis/models/office.dart';
import 'package:anavis/models/timeslot.dart';
import 'package:anavis/services/office_service.dart';
import 'package:anavis/viewargs/office_prenotation_recap_args.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/donor_request_widget.dart';
import 'package:anavis/views/widgets/fab_button.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:anavis/views/widgets/message_painter.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class OfficePrenotationTimeView extends StatefulWidget {
  final String donorMail;
  final Office office;
  OfficePrenotationTimeView({
    @required this.donorMail,
    @required this.office,
  });

  @override
  _OfficePrenotationTimeViewState createState() =>
      _OfficePrenotationTimeViewState();
}

class _OfficePrenotationTimeViewState extends State<OfficePrenotationTimeView> {
  String _timeSelected;
  String _timeFormatted;
  List<TimeSlot> _availableTimeTables;

  Future<void> fetchTimeFromOffice() async {
    _availableTimeTables = await OfficeService(context)
        .getAvailableTimeTablesByOffice(widget.office.getMail());
  }

  List<DropdownMenuItem> createListItem() {
    this.fetchTimeFromOffice();
    List<DropdownMenuItem> listTimeItem = new List<DropdownMenuItem>();
    for (var slot in this._availableTimeTables) {
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

  Future<void> initFuture() async {
    await Future.wait([
      this.fetchTimeFromOffice(),
    ]);
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
            if (_availableTimeTables.isEmpty) {
              return MessagePainter(
                isGood: false,
                negativeTitle: "Date non disponibili",
                negativeMsg:
                    "Non sono disponibili date per donare presso questo ufficio",
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName('OfficeView'));
                  ConfirmationFlushbar(
                    "Date non disponibili",
                    "Non sono disponibili date per donare presso questo ufficio",
                    false,
                  ).show(context);
                },
              );
            } else
              return Scaffold(
                floatingActionButton: _timeSelected != null
                    ? FABRightArrow(
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, '/office/prenotations/recap',
                              arguments: new OfficePrenotationRecapArgs(
                                  widget.donorMail,
                                  this._timeSelected,
                                  this._timeFormatted,
                                  widget.office));
                        },
                      )
                    : FABLeftArrow(
                        nameOffice: widget.donorMail
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
        ;
      },
    );
  }
}
