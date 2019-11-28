import 'package:anavis/model/app_state.dart';
import 'package:anavis/widgets/donor_request_widget.dart';
import 'package:anavis/widgets/fab_right.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorRequestTimeView extends StatefulWidget {
  final String office;

  DonorRequestTimeView({@required this.office});

  @override
  _DonorRequestTimeViewState createState() => _DonorRequestTimeViewState();
}

class _DonorRequestTimeViewState extends State<DonorRequestTimeView> {
  String _timeSelected;

  void fetchTimeFromOffice() {
    Provider.of<AppState>(context).setOfficeTimeTables(this.widget.office);
  }

  List<DropdownMenuItem> createListItem() {
    this.fetchTimeFromOffice();
    List<DropdownMenuItem> listTimeItem = new List<DropdownMenuItem>();
    for (var timeString
        in Provider.of<AppState>(context).getOfficeTimeTables()) {
      listTimeItem.add(new DropdownMenuItem(
        value: timeString,
        child: Container(
          child: Text(
            timeString,
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
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return DonorRequestTimeView(office: _timeSelected);
                // }));
              },
            )
          : null,
      backgroundColor: Colors.white,
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
          });
        },
      ),
    );
  }
}
