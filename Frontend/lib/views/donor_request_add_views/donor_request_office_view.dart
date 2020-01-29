import 'package:anavis/services/office_service.dart';
import 'package:anavis/views/widgets/donor_request_widget.dart';
import 'package:anavis/views/widgets/fab_button.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:flutter/material.dart';

import '../donor_view.dart';

class DonorRequestOfficeView extends StatefulWidget {
  @override
  _DonorRequestOfficeViewState createState() => _DonorRequestOfficeViewState();
}

class _DonorRequestOfficeViewState extends State<DonorRequestOfficeView> {
  String _officeSelected;
  Map<String, String> _officeMailsAndNames = new Map<String, String>();

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

  Future<void> initFuture() async {
    await Future.wait([
      this.setOfficeMailsAndNames(),
    ]);
  }

  Future<void> setOfficeMailsAndNames() async {
    _officeMailsAndNames =
        await OfficeService(context).getOfficeMailsAndNames();
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
              floatingActionButton: Stack(
                children: <Widget>[
                  _officeSelected != null
                      ? FABRightArrow(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/donor/officerequest/timeview',
                              arguments: _officeSelected,
                            );
                          },
                        )
                      : SizedBox(),
                  FABLeftArrow(
                    nameOffice: "Homepage",
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/donor',
                        arguments: new DonorView(),
                      );
                    },
                  ),
                ],
              ),
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
        return null;
      },
    );
  }
}
