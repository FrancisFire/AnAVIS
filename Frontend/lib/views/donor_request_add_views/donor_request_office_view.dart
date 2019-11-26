import 'package:anavis/model/app_state.dart';
import 'package:anavis/widgets/donor_request_widget.dart';
import 'package:anavis/widgets/fab_right.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorRequestOfficeView extends StatefulWidget {
  @override
  _DonorRequestOfficeViewState createState() => _DonorRequestOfficeViewState();
}

class _DonorRequestOfficeViewState extends State<DonorRequestOfficeView> {
  String _officeSelected;

  List<DropdownMenuItem> createListItem() {
    List<DropdownMenuItem> listOfficeItem = new List<DropdownMenuItem>();
    for (var officeString in Provider.of<AppState>(context).getOfficeNames()) {
      listOfficeItem.add(new DropdownMenuItem(
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
    return listOfficeItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _officeSelected != null
          ? FABRightArrow(
              onPressed: () {},
            )
          : null,
      backgroundColor: Colors.white,
      body: BuildDonorRequestWidget(
        fetchItems: createListItem(),
        title: "Ufficio",
        subtitle:
            "Di seguito potrai selezionare l'ufficio di competenza nel quale desideri effettuare la donazione",
        icon: Icon(
          Icons.home,
          size: 42,
          color: Colors.red,
        ),
        labelDropDown: "Seleziona l'ufficio",
        officeSelected: _officeSelected,
        onChanged: (newValue) {
          setState(() {
            _officeSelected = newValue;
          });
        },
      ),
    );
  }
}
