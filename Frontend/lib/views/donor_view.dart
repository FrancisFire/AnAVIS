import 'package:anavis/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DonorView extends StatefulWidget {
  @override
  _DonorViewState createState() => _DonorViewState();
}

class _DonorViewState extends State<DonorView> {
  bool _donorCanDonate;
  String _email;

  @override
  Widget build(BuildContext context) {
    _email = Provider.of<AppState>(context).getDonorMail();
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
                      _email,
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
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            FabCircularMenu(
              child: Container(
                child: Center(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        top: (MediaQuery.of(context).size.height / 4),
                        bottom: 8,
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Swiper(
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Colors.white,
                                elevation: 7,
                                shape: RoundedRectangleBorder(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(26.0),
                                  ),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      "Possiamo mostrare delle cose qui che possono essere un grafico o un calendario",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemCount: 10,
                            itemWidth: 330.0,
                            itemHeight:
                                (MediaQuery.of(context).size.height / 1.6),
                            layout: SwiperLayout.STACK,
                          ),
                        ),
                      ),
                    ],
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
        turns: new AlwaysStoppedAnimation(5 / 360),
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
              //_showCanDonatePopup();
              Navigator.pushNamed(context, '/donor/candonate');
              /* Navigator.push(context, MaterialPageRoute(builder: (context) {
                return DonorCanDonateView();
              }));*/
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
        turns: new AlwaysStoppedAnimation(5 / 360),
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
              Icons.message,
              color: Colors.red,
            ),
            onPressed: () {
              if (_donorCanDonate) {
                Navigator.pushNamed(context, '/donor/officerequest');
                /* Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return DonorRequestOfficeView();
                }));*/
              } else {
                Flushbar(
                  margin: EdgeInsets.all(8),
                  borderRadius: 26,
                  shouldIconPulse: true,
                  title: "Operazione non consentita",
                  icon: Icon(
                    Icons.info_outline,
                    size: 28.0,
                    color: Colors.red[600],
                  ),
                  message:
                      "Al momento non puoi richiedere di prenotare una donazione, prova tra un pò di giorni.",
                  duration: Duration(
                    seconds: 6,
                  ),
                  isDismissible: true,
                  dismissDirection: FlushbarDismissDirection.HORIZONTAL,
                )..show(context);
              }
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
        turns: new AlwaysStoppedAnimation(5 / 360),
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
