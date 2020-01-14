import 'package:anavis/providers/app_state.dart';
import 'package:anavis/providers/current_office_state.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/viewargs/office_prenotation_time_view_args.dart';
import 'package:anavis/widgets/donor_request_widget.dart';
import 'package:anavis/widgets/fab_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfficePrenotationDonorView extends StatefulWidget {
  final String officeName;

  OfficePrenotationDonorView({
    @required this.officeName,
  });

  @override
  _OfficePrenotationDonorViewState createState() =>
      _OfficePrenotationDonorViewState();
}

class _OfficePrenotationDonorViewState
    extends State<OfficePrenotationDonorView> {
  String _donorSelected;

  void fetchDonorByOffice() async {
    await Provider.of<AppState>(context)
        .setAvailableDonorsMailsByOffice(this.widget.officeName);
  }

  List<DropdownMenuItem> createListItem() {
    this.fetchDonorByOffice();
    List<DropdownMenuItem> listDonorItem = new List<DropdownMenuItem>();
    for (var donor
        in Provider.of<AppState>(context).getAvailableDonorsMailsByOffice()) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _donorSelected != null
          ? FABRightArrow(
              onPressed: () async {
                await Provider.of<CurrentOfficeState>(context)
                    .setOfficeTimeTables();
                if (Provider.of<CurrentOfficeState>(context)
                    .getAvailableTimeTables()
                    .isEmpty) {
                  Navigator.pop(context);
                  Provider.of<AppState>(context).showFlushbar(
                      'Date non disponibili',
                      'Non sono presenti date disponibili per il seguente ufficio',
                      false,
                      context);
                } else {
                  Navigator.pushReplacementNamed(
                    context,
                    '/office/prenotations/timeview',
                    arguments: new OfficePrenotationTimeViewArgs(
                      widget.officeName,
                      _donorSelected,
                    ),
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
