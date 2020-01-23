import 'package:anavis/models/activeprenotation.dart';
import 'package:anavis/models/closedprenotation.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/models/requestprenotation.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/services/donation_service.dart';
import 'package:anavis/services/donor_service.dart';
import 'package:anavis/services/prenotation_service.dart';
import 'package:anavis/services/request_service.dart';
import 'package:anavis/views/widgets/button_fab_homepage.dart';
import 'package:anavis/views/widgets/clip_path.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:anavis/views/widgets/main_card_donation.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class DonorView extends StatefulWidget {
  @override
  _DonorViewState createState() => _DonorViewState();
}

class _DonorViewState extends State<DonorView> {
  Donor _donor;
  bool showLegend = true;

  int prenotationCount = 0;
  int pendingCount = 0;
  int pendingRequestCount = 0;

  List<int> selectedSpots = [];
  int touchedIndex;
  int lastPanStartOnIndex = -1;
  List<ClosedPrenotation> _donations;

  Future<void> initFuture() async {
    await this.setDonor();
    await Future.wait([
      this.setRequestsCount(),
      this.setPendingPrenotationsCount(),
      this.setPrenotationsCount(),
      this.setDonations(),
    ]);
  }

  Future<void> setDonor() async {
    this._donor =
        await DonorService(context).getDonorByMail(AppState().getUserMail());
  }

  Future<void> setRequestsCount() async {
    List<RequestPrenotation> requests =
        await RequestService(context).getRequestsByDonor(_donor.getMail());
    pendingRequestCount = requests.length;
  }

  Future<void> setPendingPrenotationsCount() async {
    List<ActivePrenotation> notConfirmedPrenotations =
        await PrenotationService(context)
            .getDonorNotConfirmedPrenotations(_donor.getMail());
    pendingCount = notConfirmedPrenotations.length;
  }

  Future<void> setPrenotationsCount() async {
    List<ActivePrenotation> activePrenotations =
        await PrenotationService(context)
            .getPrenotationsByDonor(_donor.getMail());
    prenotationCount = activePrenotations.length;
  }

  Future<void> setDonations() async {
    this._donations =
        await DonationService(context).getDonationsByDonor(_donor.getMail());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
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
                    padding: const EdgeInsets.only(
                      top: 46,
                      left: 16,
                      right: 16,
                    ),
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
                            "${this._donor.getSurname()} ${this._donor.getName()} ",
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
                                backgroundColor: this._donor.canDonate()
                                    ? Colors.green
                                    : Colors.red,
                                elevation: 14,
                                avatar: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    this._donor.canDonate()
                                        ? Icons.check
                                        : Icons.warning,
                                    color: this._donor.canDonate()
                                        ? Colors.green
                                        : Colors.red,
                                    size: 18.0,
                                  ),
                                ),
                                label: Text(
                                  this._donor.canDonate()
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
                  Container(
                    child: Center(
                      child: Stack(
                        children: <Widget>[
                          Positioned.fill(
                            top: (MediaQuery.of(context).size.height / 4),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: this._donations.length == 0
                                  ? Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 32,
                                        ),
                                        child: Card(
                                          elevation: 8,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                26.0,
                                              ),
                                            ),
                                          ),
                                          child: ListTile(
                                            title:
                                                Text("Storico donazioni vuoto"),
                                            subtitle: Text(
                                                "Non è presente alcuna donazione effettuata"),
                                          ),
                                        ),
                                      ),
                                    )
                                  : this._donations.length == 1
                                      ? Center(
                                          child: Container(
                                            width: 330,
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                1.7),
                                            child: MainCardDonorRecapDonation(
                                              closedPrenotation:
                                                  this._donations[0],
                                            ),
                                          ),
                                        )
                                      : Swiper(
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return MainCardDonorRecapDonation(
                                              closedPrenotation:
                                                  this._donations[index],
                                            );
                                          },
                                          itemCount: this._donations.length,
                                          itemWidth: 330.0,
                                          index: 0,
                                          itemHeight: (MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.7),
                                          layout: SwiperLayout.STACK,
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              floatingActionButton: ButtonFABHomePage(
                iconFab: iconFAB(),
              ),
            );
        }
        return null;
      },
    );
  }

  List<SpeedDialChild> iconFAB() {
    return <SpeedDialChild>[
      SpeedDialChild(
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.pushNamed(context, '/donor/candonate',
              arguments: this._donor);
        },
        label: 'Possibilità di donare',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      SpeedDialChild(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: 'Richiesta di donazione',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        onTap: () {
          if (_donor.canDonate()) {
            Navigator.pushNamed(
              context,
              '/donor/officerequest',
            );
          } else {
            ConfirmationFlushbar(
              "Operazione non consentita",
              "Al momento non puoi richiedere di prenotare una donazione, prova tra un pò di giorni.",
              false,
            ).show(context);
          }
        },
      ),
      SpeedDialChild(
        label: 'Lista di prenotazioni',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        child: Center(
          child: Badge(
            toAnimate: false,
            showBadge: this.prenotationCount > 0 ? true : false,
            badgeContent: Padding(
              padding: const EdgeInsets.all(1.4),
              child: Text(this.prenotationCount.toString()),
            ),
            position: BadgePosition.topRight(top: -9, right: -2),
            badgeColor: Colors.white,
            child: Icon(
              Icons.receipt,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/donor/prenotationsview',
              arguments: this._donor);
        },
      ),
      SpeedDialChild(
        label: 'Lista di richieste',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        child: Center(
          child: Badge(
            toAnimate: false,
            showBadge: this.pendingRequestCount > 0 ? true : false,
            badgeContent: Padding(
              padding: const EdgeInsets.all(1.4),
              child: Text(this.pendingRequestCount.toString()),
            ),
            position: BadgePosition.topRight(top: -9, right: -2),
            badgeColor: Colors.white,
            child: Icon(
              Icons.calendar_view_day,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(context, '/donor/requestsview',
              arguments: this._donor);
        },
      ),
      SpeedDialChild(
        label: 'Modifiche dall\'ufficio',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        child: Center(
          child: Badge(
            toAnimate: false,
            showBadge: this.pendingCount > 0 ? true : false,
            badgeContent: Padding(
              padding: const EdgeInsets.all(1.4),
              child: Text(this.pendingCount.toString()),
            ),
            position: BadgePosition.topRight(top: -9, right: -2),
            badgeColor: Colors.white,
            child: Icon(
              Icons.calendar_today,
              color: Colors.white,
            ),
          ),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/donor/pendingprenotationsview',
            arguments: this._donor,
          );
        },
      ),
      SpeedDialChild(
        label: 'Profilo',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        child: Icon(
          Icons.account_circle,
          color: Colors.white,
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/admin',
          );
        },
      ),
      SpeedDialChild(
        label: 'Logout',
        labelBackgroundColor: Colors.redAccent,
        backgroundColor: Colors.redAccent,
        labelStyle: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
        child: Icon(
          Icons.backspace,
          color: Colors.white,
        ),
        onTap: () {
          AppState().logout();
          Navigator.pushReplacementNamed(
            context,
            '/',
          );
        },
      ),
    ];
  }
}
