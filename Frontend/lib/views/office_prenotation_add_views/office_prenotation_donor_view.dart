import 'package:anavis/models/timeslot.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/services/donor_service.dart';
import 'package:anavis/services/office_service.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/donor_request_widget.dart';
import 'package:anavis/views/widgets/fab_button.dart';
import 'package:flutter/material.dart';

class OfficePrenotationDonorView extends StatefulWidget {
  @override
  _OfficePrenotationDonorViewState createState() =>
      _OfficePrenotationDonorViewState();
}

class _OfficePrenotationDonorViewState
    extends State<OfficePrenotationDonorView> {
  String _donorSelected;
  List<String> _availableDonors;
  String _mail;
  List<TimeSlot> _officeTimeTable;

  Future<void> fetchDonorByOffice() async {
    _availableDonors.clear();
    List<Donor> donors =
        await DonorService(context).getAvailableDonorsByOfficeId(this._mail);
    for (var donor in donors) {
      _availableDonors.add(donor.getMail());
    }
  }

  List<DropdownMenuItem> createListItem() {
    this.fetchDonorByOffice();
    List<DropdownMenuItem> listDonorItem = new List<DropdownMenuItem>();
    for (var donor in _availableDonors) {
      listDonorItem.add(
        new DropdownMenuItem(
          value: donor,
          child: Container(
            child: Text(
              donor,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
    return listDonorItem;
  }

  Future<void> fetchAvailableTimeTables() async {
    _officeTimeTable =
        await OfficeService(context).getAvailableTimeTablesByOffice(this._mail);
  }

  @override
  void initState() {
    super.initState();
    _mail = AppState().getUserMail();
    _availableDonors = new List<String>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _donorSelected != null
          ? FABRightArrow(
              onPressed: () async {
                await this.fetchAvailableTimeTables();
                if (this._officeTimeTable.isEmpty) {
                  Navigator.pop(context);
                  Navigator.popUntil(
                      context, ModalRoute.withName('OfficeView'));
                  ConfirmationFlushbar(
                    'Date non disponibili',
                    'Non sono presenti date disponibili per il seguente ufficio',
                    false,
                  ).show(context);
                  /* Provider.of<AppState>(context).showFlushbar(
                      'Date non disponibili',
                      'Non sono presenti date disponibili per il seguente ufficio',
                      false,
                      context);*/
                } else {
                  Navigator.pushReplacementNamed(
                    context,
                    '/office/prenotations/timeview',
                    arguments: _donorSelected,
                  );
                }
              },
            )
          : null,
      backgroundColor: Colors.white,
      body: BuildDonorRequestWidget(
        fetchItems: createListItem(),
        title: "Donatore",
        subtitle:
            "Di seguito potrai selezionare il donatore relativo alla donazione",
        icon: Icon(
          Icons.home,
          size: 42,
          color: Colors.red,
        ),
        labelDropDown: "Seleziona il donatore",
        valueSelected: _donorSelected,
        onChanged: (newValue) {
          setState(() {
            _donorSelected = newValue;
          });
        },
      ),
    );
  }
}
