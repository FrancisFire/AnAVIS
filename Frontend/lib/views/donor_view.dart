import 'package:anavis/models/app_state.dart';
import 'package:anavis/models/current_donor_state.dart';
import 'package:anavis/widgets/clip_path.dart';
import 'package:anavis/widgets/fab_item.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:provider/provider.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DonorView extends StatefulWidget {
  @override
  _DonorViewState createState() => _DonorViewState();
}

class _DonorViewState extends State<DonorView> {
  bool _donorCanDonate;
  String _email;

  int prenotationCount = 0;
  int pendingCount = 0;
  int getPrenotationCount() {
    Provider.of<CurrentDonorState>(context).getDonorActivePrenotations().then(
      (onValue) {
        setState(() {
          prenotationCount = onValue.length;
        });
      },
    );
    return prenotationCount;
  }

  int getPendingCount() {
    Provider.of<CurrentDonorState>(context).getDonorPendingPrenotations().then(
      (onValue) {
        setState(() {
          pendingCount = onValue.length;
        });
      },
    );
    return pendingCount;
  }

  @override
  Widget build(BuildContext context) {
    _email = Provider.of<CurrentDonorState>(context).getDonorMail();
    _donorCanDonate = Provider.of<CurrentDonorState>(context).getCanDonate();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: (MediaQuery.of(context).size.height / 3),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.red[800],
                    Colors.red[700],
                    Colors.red[600],
                    Colors.red[400],
                  ],
                ),
              ),
            ),
          ),
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
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                ),
                Flexible(
                  child: AutoSizeText(
                    _email,
                    style: TextStyle(
                      fontSize: 52,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                  ),
                ),
                Flexible(
                  child: Row(
                    children: <Widget>[
                      Chip(
                        backgroundColor: Provider.of<CurrentDonorState>(context)
                                .getCanDonate()
                            ? Colors.green
                            : Colors.red,
                        elevation: 14,
                        avatar: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Provider.of<CurrentDonorState>(context)
                                    .getCanDonate()
                                ? Icons.check
                                : Icons.warning,
                            color: Provider.of<CurrentDonorState>(context)
                                    .getCanDonate()
                                ? Colors.green
                                : Colors.red,
                            size: 18.0,
                          ),
                        ),
                        label: Text(
                          Provider.of<CurrentDonorState>(context).getCanDonate()
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
                              (MediaQuery.of(context).size.height / 1.8),
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
            options: iconFAB(),
          ),
        ],
      ),
    );
  }

  List<Widget> iconFAB() {
    return <Widget>[
      BuildRaisedButtonFAB(
        icon: Icon(
          Icons.done_outline,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/donor/candonate',
          );
        },
      ),
      BuildRaisedButtonFAB(
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          if (_donorCanDonate) {
            Navigator.pushNamed(
              context,
              '/donor/officerequest',
            );
          } else {
            Provider.of<AppState>(context).showFlushbar(
                "Operazione non consentita",
                "Al momento non puoi richiedere di prenotare una donazione, prova tra un pò di giorni.",
                false,
                context);
          }
        },
      ),
      Badge(
        showBadge: getPrenotationCount() > 0 ? true : false,
        badgeContent: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(getPrenotationCount().toString()),
        ),
        position: BadgePosition.topRight(right: 1, top: 2),
        badgeColor: Colors.white,
        child: BuildRaisedButtonFAB(
          icon: Icon(
            Icons.receipt,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/donor/prenotationsview',
            );
          },
        ),
      ),
      Badge(
        showBadge: getPendingCount() > 0 ? true : false,
        badgeContent: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(getPendingCount().toString()),
        ),
        position: BadgePosition.topRight(right: 1, top: 2),
        badgeColor: Colors.white,
        child: BuildRaisedButtonFAB(
          icon: Icon(
            Icons.calendar_today,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              '/donor/pendingprenotationsview',
            );
          },
        ),
      ),
      BuildRaisedButtonFAB(
        icon: Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        onPressed: () {},
      ),
    ];
  }
}
