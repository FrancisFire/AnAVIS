import 'package:anavis/providers/app_state.dart';
import 'package:anavis/providers/current_office_state.dart';
import 'package:anavis/viewargs/office_prenotationupdate_recap_args.dart';
import 'package:anavis/widgets/button_card_bottom.dart';
import 'package:anavis/widgets/form_field_general.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DialogModificationPrenotation extends StatefulWidget {
  final String donor;
  final String prenotationId;
  DialogModificationPrenotation({
    @required this.donor,
    @required this.prenotationId,
  });
  _DialogModificationPrenotationState createState() =>
      _DialogModificationPrenotationState();
}

class _DialogModificationPrenotationState
    extends State<DialogModificationPrenotation> {
  String _newOffice, _newHour;
  List<DropdownMenuItem> _offices, _hours;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _hours = this.createHourItem(context);
      _offices = this.createOfficeNames(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      child: dialogContent(context),
    );
  }

  static String restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp(r"(\.\d{6})\d+"), (m) => m[1]);

  static String nicerTime(String timeNotNice) {
    return formatDate(DateTime.parse(restrictFractionalSeconds(timeNotNice)),
        ["Data: ", dd, '-', mm, '-', yyyy, " | Orario: ", HH, ":", nn]);
  }

  List<DropdownMenuItem> createOfficeNames(BuildContext context) {
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

  void fetchTimeFromOffice() async {
    await Provider.of<CurrentOfficeState>(context).setOfficeTimeTables();
  }

  List<DropdownMenuItem> createHourItem(BuildContext context) {
    this.fetchTimeFromOffice();
    List<DropdownMenuItem> listTimeItem = new List<DropdownMenuItem>();
    for (var slot
        in Provider.of<CurrentOfficeState>(context).getAvailableTimeTables()) {
      String _timeFormatted = nicerTime(slot.getDateTime());
      listTimeItem.add(new DropdownMenuItem(
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
    return listTimeItem;
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
                      text: widget.donor,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.0),
              FormFieldGeneral(
                fetchItems: _offices,
                icon: Icon(
                  Icons.home,
                  color: Colors.red,
                ),
                labelDropDown: "Seleziona l'ufficio",
                valueSelected: _newOffice,
                onChanged: (newValue) {
                  setState(() {
                    _newOffice = newValue;
                  });
                },
              ),
              SizedBox(height: 24.0),
              FormFieldGeneral(
                fetchItems: _hours,
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
                      Icons.thumb_down,
                      color: Colors.white,
                    ),
                    color: Colors.red,
                    onTap: () {
                      Navigator.pop(context);
                      Provider.of<AppState>(context).showFlushbar(
                        "Operazione annullata",
                        "L'operazione di modifica è stata annullata",
                        false,
                        context,
                      );
                    },
                    title: 'Annulla',
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  ButtonForCardBottom(
                    icon: Icon(
                      Icons.thumb_up,
                      color: Colors.white,
                    ),
                    color: Colors.green,
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/office/prenotationupdate/recap',
                          arguments: new OfficePrenotationUpdateRecapArgs(
                              this.widget.donor,
                              this._newHour,
                              nicerTime(this._newHour),
                              widget.prenotationId,
                              _newOffice));
                    },
                    title: 'Conferma',
                  ),
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
                widget.donor.toString().substring(0, 2).toUpperCase(),
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
