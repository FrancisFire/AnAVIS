import 'package:anavis/providers/app_state.dart';
import 'package:anavis/providers/current_donor_state.dart';
import 'package:anavis/viewargs/donor_prenotationupdate_recap_args.dart';
import 'package:anavis/viewargs/donor_request_recap_args.dart';
import 'package:anavis/models/prenotation.dart';
import 'package:anavis/widgets/button_card_bottom.dart';
import 'package:anavis/widgets/card_prenotation_request.dart';
import 'package:anavis/widgets/confirm_alert_dialog.dart';
import 'package:anavis/widgets/delete_dialog.dart';
import 'package:anavis/widgets/painter.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DonorPendingPrenotationView extends StatefulWidget {
  @override
  _DonorPendingPrenotationViewState createState() =>
      _DonorPendingPrenotationViewState();
}

class _DonorPendingPrenotationViewState
    extends State<DonorPendingPrenotationView> {
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await Provider.of<CurrentDonorState>(context).getDonorPendingPrenotations();
    _refreshController.refreshCompleted();
  }

  static String restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp(r"(\.\d{6})\d+"), (m) => m[1]);
  static String nicerTime(String timeNotNice) {
    return formatDate(DateTime.parse(restrictFractionalSeconds(timeNotNice)),
        ["Data: ", dd, '-', mm, '-', yyyy, " | Orario: ", HH, ":", nn]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Le tue prenotazioni in attesa",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 8,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
      ),
      body: CustomPaint(
        painter: Painter(
          first: Colors.red[100],
          second: Colors.orange[200],
          background: Colors.white,
        ),
        child: Center(
          child: FutureBuilder<List<Prenotation>>(
            future: Provider.of<CurrentDonorState>(context)
                .getDonorPendingPrenotations(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new RequestCircularLoading();
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return new RequestCircularLoading();
                case ConnectionState.done:
                  if (snapshot.hasError) return new RequestCircularLoading();
                  if (snapshot.data.isEmpty) {
                    return new Center(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          18.0,
                        ),
                        child: Card(
                          elevation: 42,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              16.0,
                            ),
                            child: Text(
                              "Non sono presenti richieste di donazione al momento, si prega di riprovare più tardi",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onRefresh,
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropMaterialHeader(
                      backgroundColor: Colors.red[900],
                    ),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return CardForPrenotationAndRequest(
                          id: snapshot.data[index].getOfficeId(),
                          email: snapshot.data[index].getDonorId(),
                          hour: snapshot.data[index].getHour(),
                          buttonBar: ButtonBar(
                            children: <Widget>[
                              ButtonForCardBottom(
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                ),
                                color: Colors.orange,
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/donor/prenotationupdate/recap',
                                      arguments:
                                          new DonorPrenotationUpdateRecapArgs(
                                              snapshot.data[index]
                                                  .getOfficeId(),
                                              snapshot.data[index].getHour(),
                                              nicerTime(snapshot.data[index]
                                                  .getHour()),
                                              snapshot.data[index].getId()));
                                },
                                title: 'Visualizza riepilogo',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
              }
              return null; // unreachable
            },
          ),
        ),
      ),
    );
  }
}

class RequestCircularLoading extends StatelessWidget {
  const RequestCircularLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        strokeWidth: 5,
      ),
    );
  }
}
