import 'package:anavis/models/office.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/services/donor_service.dart';
import 'package:anavis/viewargs/office_prenotation_time_view_args.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/donor_request_widget.dart';
import 'package:anavis/views/widgets/fab_button.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:anavis/views/widgets/message_painter.dart';
import 'package:flutter/material.dart';
import '../office_view.dart';

class OfficePrenotationDonorView extends StatefulWidget {
  final Office office;
  OfficePrenotationDonorView({@required this.office});
  @override
  _OfficePrenotationDonorViewState createState() =>
      _OfficePrenotationDonorViewState();
}

class _OfficePrenotationDonorViewState
    extends State<OfficePrenotationDonorView> {
  String _donorSelected;
  List<String> _availableDonors;

  Future<void> fetchDonorByOffice() async {
    _availableDonors = new List<String>();

    List<Donor> donors = await DonorService(context)
        .getAvailableDonorsByOfficeId(widget.office.getMail());
    for (var donor in donors) {
      _availableDonors.add(donor.getMail());
    }
  }

  List<DropdownMenuItem> createListItem() {
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

  Future<void> initFuture() async {
    await Future.wait([
      this.fetchDonorByOffice(),
    ]);
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
            if (_availableDonors.isEmpty) {
              return MessagePainter(
                isGood: false,
                negativeTitle: "Donatori non disponibili",
                negativeMsg:
                    "Non sono disponibili donatori presso questo ufficio",
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName('OfficeView'));
                  ConfirmationFlushbar(
                    "Donatori non disponibili",
                    "Non sono disponibili donatori presso questo ufficio",
                    false,
                  ).show(context);
                },
              );
            } else
              return Scaffold(
                floatingActionButton: Stack(
                  children: <Widget>[
                    _donorSelected != null
                        ? FABRightArrow(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/office/prenotations/timeview',
                                arguments: new OfficePrenotationTimeViewArgs(
                                    _donorSelected, widget.office),
                              );
                            },
                          )
                        : SizedBox(),
                    FABLeftArrow(
                      nameOffice: "Homepage",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          '/office',
                          arguments: new OfficeView(),
                        );
                      },
                    ),
                  ],
                ),
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
        return null;
      },
    );
  }
}
