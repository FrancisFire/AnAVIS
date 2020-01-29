import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/services/office_service.dart';

import 'package:anavis/viewargs/guest_create_donor_recap_args.dart';
import 'package:anavis/views/login_view.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/creation_field.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:anavis/views/widgets/painter.dart';
import 'package:anavis/views/widgets/remove_glow.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:date_format/date_format.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class GuestCreateDonorView extends StatefulWidget {
  final AuthCredentials credentials;

  GuestCreateDonorView({
    @required this.credentials,
  });

  @override
  _GuestCreateDonorViewState createState() => _GuestCreateDonorViewState();
}

class _GuestCreateDonorViewState extends State<GuestCreateDonorView> {
  String _name;
  String _surname;
  DateTime _birthday;
  String _birthPlace;
  String _locationAVIS;
  DonorCategory _gender;

  Map<String, String> _officeMailsAndNames = new Map<String, String>();

  Future<void> initFuture() async {
    await Future.wait([
      this.setOfficeMailsAndNames(),
    ]);
  }

  Future<void> setOfficeMailsAndNames() async {
    _officeMailsAndNames =
        await OfficeService(context).getOfficeMailsAndNames();
  }

  final format = DateFormat("dd-MM-yyyy");

  Widget fab(
      String a, String b, DateTime c, String d, String f, DonorCategory e) {
    return FloatingActionButton(
      child: Icon(
        Icons.person_add,
        color: Colors.white,
      ),
      backgroundColor: Colors.orange,
      onPressed: () {
        print("NOME: " + a);
        print("COGNOME: " + b);
        print("BIRTHDAT: " + c.toString());
        print("PLACE: " + d);
        print("LOCATION AVIS: " + f.toString());
        print("GENDER:" + e.toString());
        print("HE");
        if (a != null &&
            b != null &&
            (c != DateTime.now() && c.toString().isNotEmpty && c != null) &&
            d != null &&
            e != null &&
            f != null) {
          Navigator.pushReplacementNamed(
            context,
            '/guest/createuser/recap',
            arguments: new GuestCreateDonorRecapArgs(
              widget.credentials,
              new Donor(
                widget.credentials.getMail(),
                this._locationAVIS,
                this._gender,
                this._name,
                this._surname,
                formatDate(this._birthday, [
                  '20',
                  yy,
                  '-',
                  mm,
                  '-',
                  dd,
                  'T',
                  HH,
                  ':',
                  nn,
                  ':',
                  ss,
                  '.000+0000',
                ]),
                this._birthPlace,
              ),
            ),
          );
        } else {
          new ConfirmationFlushbar(
            "Compilare tutti i campi",
            "Per procedere con la registrazione è fondamentale compilare tutti i campi visualizzati",
            false,
          ).show(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initFuture(),
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
              floatingActionButton: fab(
                this._name,
                this._surname,
                this._birthday,
                this._birthPlace,
                this._locationAVIS,
                this._gender,
              ),
              body: CustomPaint(
                painter: Painter(
                  first: Colors.red[400],
                  second: Colors.red[900],
                  background: Colors.red[600],
                ),
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 4),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Consts.padding),
                          topRight: Radius.circular(Consts.padding),
                          bottomLeft: Radius.zero,
                          bottomRight: Radius.zero,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10.0,
                            offset: Offset(0.0, 10.0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: ScrollConfiguration(
                          behavior: RemoveGlow(),
                          child: ListView(
                            children: <Widget>[
                              Card(
                                elevation: 8,
                                color: Colors.deepOrange[600],
                                margin: EdgeInsets.all(8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        leading: Icon(
                                          Icons.warning,
                                          color: Colors.white,
                                          size: 52,
                                        ),
                                        subtitle: Text(
                                          "Una volta completati tutti i campi potrai cliccare sul pulsante in basso a destra per terminare la registrazione",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                          ),
                                        ),
                                        dense: true,
                                        title: Text(
                                          "Attenzione!",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ButtonBar(
                                        children: <Widget>[
                                          RaisedButton.icon(
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(18.0),
                                                ),
                                              ),
                                              color: Colors.orange,
                                              icon: Icon(
                                                Icons.home,
                                                color: Colors.white,
                                              ),
                                              label: Text(
                                                "Torna alla homepage",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  '/',
                                                  arguments: new LoginView(),
                                                );
                                              })
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              CreationField(
                                chipTitle: "Inserisci il tuo nome",
                                hint: "Nome",
                                icon: Icon(
                                  Icons.supervised_user_circle,
                                  color: Colors.red[600],
                                ),
                                onSaved: (newValue) {
                                  this._name = newValue;
                                  print("Nome ${this._name}");
                                },
                                isPass: false,
                              ),
                              CreationField(
                                icon: Icon(
                                  Icons.contacts,
                                  color: Colors.red[600],
                                ),
                                chipTitle: "Inserisci il tuo cognome",
                                hint: "Cognome",
                                onSaved: (newValue) {
                                  this._surname = newValue;
                                  print("Cognome ${this._surname}");
                                },
                                isPass: false,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Chip(
                                label: Text("Seleziona il tuo sesso"),
                              ),
                              Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Colors.red,
                                ),
                                child: ButtonTheme(
                                  child: CategorySelector(
                                    setCategory: (cat) {
                                      this._gender = cat;
                                      print("Gender ${this._gender}");
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Chip(
                                label: Text(
                                    "Seleziona l'ufficio AVIS di riferimento"),
                              ),
                              Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: Colors.red,
                                ),
                                child: ButtonTheme(
                                  child: OfficeSelector(
                                    officeMailsAndNames: _officeMailsAndNames,
                                    setOffice: (mail) {
                                      this._locationAVIS = mail;
                                      print("Mail: ${this._locationAVIS}");
                                    },
                                  ),
                                ),
                              ),
                              CreationField(
                                icon: Icon(
                                  Icons.map,
                                  color: Colors.red[600],
                                ),
                                chipTitle: "Inserisci il tuo luogo di nascita",
                                hint: "Luogo",
                                onSaved: (newValue) {
                                  this._birthPlace = newValue;
                                  print("Luogo: ${this._birthPlace}");
                                },
                                isPass: false,
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Chip(
                                label: Text("Inserisci la data di compleanno"),
                              ),
                              DateTimeField(
                                format: format,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText: "Inserisci una data",
                                  fillColor: Colors.red,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  icon: Icon(
                                    Icons.calendar_today,
                                    color: Colors.red[600],
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        24.0,
                                      ),
                                    ),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                onChanged: (DateTime newDate) {
                                  this._birthday = newDate;
                                  print("Data ${this._birthday}");
                                },
                                onShowPicker: (context, currentValue) async {
                                  _birthday = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: currentValue ??
                                        DateTime.now()
                                            .subtract(new Duration(days: 6570)),
                                    lastDate: DateTime.now()
                                        .subtract(new Duration(days: 6570)),
                                  );
                                  if (_birthday != null) {
                                    return _birthday;
                                  }
                                  return currentValue;
                                },
                              ),
                              SizedBox(
                                height: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: Consts.avatarRadius - 14),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            AutoSizeText(
                              'Benvenuto!',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: new BorderRadius.circular(62.0),
                                  child: Container(
                                    height: 4,
                                    width: 80,
                                    color: Colors.white,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 6),
                              child: AutoSizeText(
                                widget.credentials.getMail() +
                                    " registrati alla piattaforma come nuovo utente e compila i seguenti campi",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
        return null;
      },
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

class OfficeSelector extends StatefulWidget {
  final Map<String, String> officeMailsAndNames;
  final Function setOffice;
  OfficeSelector(
      {@required this.officeMailsAndNames, @required this.setOffice});
  @override
  _OfficeSelectorState createState() => _OfficeSelectorState();
}

class _OfficeSelectorState extends State<OfficeSelector> {
  String _selectedOfficeName;

  List<DropdownMenuItem> createListItem() {
    List<DropdownMenuItem> listOfficeItem = new List<DropdownMenuItem>();
    widget.officeMailsAndNames.forEach((key, value) {
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
  void initState() {
    super.initState();
    _selectedOfficeName = widget.officeMailsAndNames.keys.first;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.red,
        icon: Icon(
          Icons.location_city,
          color: Colors.red[600],
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              24.0,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      hint: Text(
        "Seleziona l'ufficio AVIS",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      iconEnabledColor: Colors.white,
      elevation: 18,
      value: _selectedOfficeName,
      isDense: true,
      items: createListItem(),
      onChanged: (newValue) {
        setState(() {
          widget.setOffice(newValue);
          _selectedOfficeName = newValue;
        });
      },
    );
  }
}

class CategorySelector extends StatefulWidget {
  final Function setCategory;
  CategorySelector({@required this.setCategory});
  @override
  _CategorySelectorState createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  DonorCategory _selectedCategory;
  String donorCategoryToString(DonorCategory don) {
    switch (don) {
      case DonorCategory.MAN:
        return "Uomo";
      case DonorCategory.FERTILEWOMAN:
        return "Donna fertile";
      case DonorCategory.NONFERTILEWOMAN:
        return "Donna non fertile";
      default:
        return "Altro";
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedCategory = DonorCategory.MAN;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.red,
        icon: Icon(
          Icons.streetview,
          color: Colors.red[600],
        ),
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              24.0,
            ),
          ),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      hint: Text(
        "Seleziona il sesso",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      iconEnabledColor: Colors.white,
      elevation: 18,
      value: _selectedCategory,
      isDense: true,
      items: <DonorCategory>[
        DonorCategory.MAN,
        DonorCategory.FERTILEWOMAN,
        DonorCategory.NONFERTILEWOMAN
      ].map((DonorCategory value) {
        return new DropdownMenuItem<DonorCategory>(
          value: value,
          child: new Text(
            donorCategoryToString(value),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          widget.setCategory(newValue);
          _selectedCategory = newValue;
        });
      },
    );
  }
}
