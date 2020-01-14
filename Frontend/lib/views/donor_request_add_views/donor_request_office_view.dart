import 'package:anavis/providers/app_state.dart';
import 'package:anavis/widgets/donor_request_widget.dart';
import 'package:anavis/widgets/fab_button.dart';
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
    Provider.of<AppState>(context)
        .getOfficeMailsAndNames()
        .forEach((key, value) {
      listOfficeItem.add(new DropdownMenuItem(
        value: key,
        child: Container(
          child: Text(
            value,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ));
    });
    return listOfficeItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _officeSelected != null
          ? FABRightArrow(
              onPressed: () {
                Navigator.pushReplacementNamed(
                    context, '/donor/officerequest/timeview',
                    arguments: _officeSelected);
              },
            )
          : null,
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
        valueSelected: _officeSelected,
        onChanged: (newValue) {
          setState(() {
            _officeSelected = newValue;
          });
        },
      ),
    );
  }
}
