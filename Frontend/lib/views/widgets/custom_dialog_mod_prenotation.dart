import 'package:anavis/models/donor.dart';
import 'package:anavis/models/office.dart';
import 'package:anavis/models/timeslot.dart';
import 'package:anavis/services/donor_service.dart';
import 'package:anavis/services/office_service.dart';
import 'package:anavis/viewargs/office_prenotationupdate_recap_args.dart';
import 'package:anavis/views/widgets/button_card_bottom.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/form_field_general.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';

class DialogModificationPrenotation extends StatefulWidget {
  final Office office;
  final String donorMail;
  final String prenotationId;

  DialogModificationPrenotation({
    @required this.office,
    @required this.donorMail,
    @required this.prenotationId,
  });
  _DialogModificationPrenotationState createState() =>
      _DialogModificationPrenotationState();
}

class _DialogModificationPrenotationState
    extends State<DialogModificationPrenotation> {
  Donor _donor;
  String _newHour;
  List<DropdownMenuItem> _listTimeItem;
  List<TimeSlot> _availableTimeTables;

  Future<void> setOfficeTimeTablesByOffice(String officeMail) async {
    _availableTimeTables =
        await OfficeService(context).getAvailableTimeTablesByOffice(officeMail);
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
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              child: dialogContent(context),
            );
        }
        return null;
      },
    );
  }

  static String restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp(r"(\.\d{6})\d+"), (m) => m[1]);

  static String nicerTime(String timeNotNice) {
    return formatDate(DateTime.parse(restrictFractionalSeconds(timeNotNice)),
        ["Data: ", dd, '-', mm, '-', yyyy, " | Orario: ", HH, ":", nn]);
  }

  Future<void> initFuture() async {
    await Future.wait([
      this.setDonor(),
      this.setOfficeTimeTablesByOffice(widget.office.getMail()),
    ]);
  }

  Future<void> setDonor() async {
    this._donor = await DonorService(context).getDonorByMail(widget.donorMail);
  }

  List<DropdownMenuItem> createHourItem(BuildContext context) {
    _listTimeItem = new List<DropdownMenuItem>();
    for (var slot in this._availableTimeTables) {
      String _timeFormatted = nicerTime(slot.getDateTime());
      _listTimeItem.add(new DropdownMenuItem(
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
    return _listTimeItem;
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                "Modifica prenotazione",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.0),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey[850],
                    fontFamily: 'Rubik',
                    fontSize: 16,
                  ),
                  text:
                      "Mediante la seguente form si modificherà la prenotazione dell'utente ",
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "${this._donor.getSurname()} ${this._donor.getName()}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              FormFieldGeneral(
                fetchItems: createHourItem(context),
                icon: Icon(
                  Icons.access_time,
                  color: Colors.red,
                ),
                labelDropDown: "Seleziona l'orario",
                valueSelected: _newHour,
                onChanged: (newValue) {
                  setState(() {
                    _newHour = newValue;
                  });
                },
              ),
              SizedBox(height: 24.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonForCardBottom(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.white,
                    ),
                    color: Colors.red,
                    onTap: () {
                      Navigator.popUntil(
                          context, ModalRoute.withName('OfficeView'));
                      ConfirmationFlushbar(
                              "Operazione annullata",
                              "L'operazione di modifica è stata annullata",
                              false)
                          .show(context);
                    },
                    title: 'Annulla',
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  _newHour != null
                      ? ButtonForCardBottom(
                          icon: Icon(
                            Icons.thumb_up,
                            color: Colors.white,
                          ),
                          color: Colors.green,
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/office/prenotationupdate/recap',
                              arguments: new OfficePrenotationUpdateRecapArgs(
                                this._donor,
                                this._newHour,
                                nicerTime(this._newHour),
                                widget.prenotationId,
                                widget.office,
                              ),
                            );
                          },
                          title: 'Conferma',
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: Consts.padding,
          right: Consts.padding,
          child: Container(
            transform: Matrix4.translationValues(
                0.0, -Consts.avatarRadius + Consts.padding, 0.0),
            child: CircleAvatar(
              backgroundColor: Colors.red[600],
              foregroundColor: Colors.white,
              radius: Consts.avatarRadius,
              child: Text(
                this
                    ._donor
                    .getSurname()
                    .toString()
                    .substring(0, 2)
                    .toUpperCase(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 36.0;
}
