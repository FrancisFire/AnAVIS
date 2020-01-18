import 'package:anavis/services/office_service.dart';
import 'package:anavis/views/widgets/donor_request_widget.dart';
import 'package:anavis/views/widgets/fab_button.dart';
import 'package:flutter/material.dart';

class DonorRequestOfficeView extends StatefulWidget {
  @override
  _DonorRequestOfficeViewState createState() => _DonorRequestOfficeViewState();
}

class _DonorRequestOfficeViewState extends State<DonorRequestOfficeView> {
  String _officeSelected;
  Map<String, String> _officeMailsAndNames = new Map<String, String>();
  OfficeService _officeService;
  List<DropdownMenuItem> createListItem() {
    List<DropdownMenuItem> listOfficeItem = new List<DropdownMenuItem>();
    _officeMailsAndNames.forEach((key, value) {
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

  void setOfficeMailsAndNames() async {
    _officeMailsAndNames = await _officeService.getOfficeMailsAndNames();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _officeService = new OfficeService(context);
  }

  @override
  Widget build(BuildContext context) {
    this.setOfficeMailsAndNames();
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
