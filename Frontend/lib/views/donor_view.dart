import 'package:anavis/model/app_state.dart';
import 'package:anavis/views/donor_candonate_view.dart';
import 'package:anavis/views/donor_request_add_views/donor_request_office_view.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';

class DonorView extends StatefulWidget {
  @override
  _DonorViewState createState() => _DonorViewState();
}

class _DonorViewState extends State<DonorView> {
  bool _donorCanDonate;

  void _showCanDonatePopup() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:
                _donorCanDonate ? Colors.green[100] : Colors.red[100],
            content: Text(
              _donorCanDonate ? "Puoi donare" : "Non puoi donare",
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Ok',
                  style: TextStyle(
                    color:
                        _donorCanDonate ? Colors.green[600] : Colors.red[600],
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    _donorCanDonate = Provider.of<AppState>(context).getCanDonate();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 46, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 24,
                  ),
                  Flexible(
                    child: AutoSizeText(
                      'Benvenuto,',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.red,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Flexible(
                    child: AutoSizeText(
                      Provider.of<AppState>(context).getDonorMail(),
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.red,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: <Widget>[
                        Chip(
                          backgroundColor:
                              Provider.of<AppState>(context).getCanDonate()
                                  ? Colors.green
                                  : Colors.red,
                          elevation: 14,
                          avatar: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Provider.of<AppState>(context).getCanDonate()
                                  ? Icons.check
                                  : Icons.warning,
                              color:
                                  Provider.of<AppState>(context).getCanDonate()
                                      ? Colors.green
                                      : Colors.red,
                              size: 18.0,
                            ),
                          ),
                          label: Text(
                            Provider.of<AppState>(context).getCanDonate()
                                ? 'Puoi donare'
                                : 'Non puoi donare',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Chip(
                          backgroundColor: Colors.grey[600],
                          elevation: 14,
                          avatar: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.map,
                              color: Colors.grey[600],
                              size: 18,
                            ),
                          ),
                          label: Text(
                            'Il tuo centro AVIS',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Flexible(
                    flex: 7,
                    fit: FlexFit.tight,
                    child: Card(
                      elevation: 14,
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(26.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            "Possiamo mostrare delle cose qui che possono essere un grafico o un calendario",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FabCircularMenu(
              child: Container(
                child: Center(
                  child: Stack(
                    children: <Widget>[],
                  ),
                ),
              ),
              ringColor: Colors.red,
              fabColor: Colors.red,
              fabOpenIcon: Icon(
                FontAwesomeIcons.tint,
              ),
              ringDiameter: MediaQuery.of(context).size.width * 1.1,
              options: buildRaisedButtonFAB(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildRaisedButtonFAB() {
    return <Widget>[
      RotationTransition(
        turns: new AlwaysStoppedAnimation(2 / 360),
        child: SizedBox(
          height: 60,
          child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(64.0),
              ),
            ),
            color: Colors.white,
            elevation: 28.0,
            icon: Icon(
              Icons.calendar_today,
              color: Colors.red,
            ),
            onPressed: () {
              _showCanDonatePopup();
            },
            label: Text(
              "Visualizza possibilità \ndi donare",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
      RotationTransition(
        turns: new AlwaysStoppedAnimation(2 / 360),
        child: SizedBox(
          height: 60,
          child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(64.0),
              ),
            ),
            color: Colors.white,
            elevation: 28.0,
            icon: Icon(
              Icons.add,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DonorRequestOfficeView();
              }));
            },
            label: Text(
              "Richiedi prenotazione \ndonazioni",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
      RotationTransition(
        turns: new AlwaysStoppedAnimation(2 / 360),
        child: SizedBox(
          height: 60,
          child: RaisedButton.icon(
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(64.0),
              ),
            ),
            color: Colors.white,
            elevation: 28.0,
            icon: Icon(
              Icons.account_circle,
              color: Colors.red,
            ),
            onPressed: () {},
            label: Text(
              "Profilo \nutente",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    ];
  }
}
