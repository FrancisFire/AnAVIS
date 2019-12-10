import 'package:anavis/model/app_state.dart';
import 'package:anavis/model/office_prenotation_time_view_args.dart';
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
        .setAvailableDonorsByOffice(this.widget.officeName);
  }

  List<DropdownMenuItem> createListItem() {
    this.fetchDonorByOffice();
    List<DropdownMenuItem> listDonorItem = new List<DropdownMenuItem>();
    for (var officeString
        in Provider.of<AppState>(context).getDonorsByOffice()) {
      listDonorItem.add(new DropdownMenuItem(
        value: officeString,
        child: Container(
          child: Text(
            officeString,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ));
    }
    return listDonorItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _donorSelected != null
          ? FABRightArrow(
              onPressed: () async {
                await Provider.of<AppState>(context)
                    .setOfficeTimeTables(this.widget.officeName);
                if (Provider.of<AppState>(context)
                    .getOfficeTimeTables()
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
                        widget.officeName, _donorSelected),
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
