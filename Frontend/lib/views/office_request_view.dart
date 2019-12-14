import 'package:anavis/models/app_state.dart';
import 'package:anavis/models/current_office_state.dart';
import 'package:anavis/models/request.dart';
import 'package:anavis/widgets/button_card_bottom.dart';
import 'package:anavis/widgets/card_prenotation_request.dart';
import 'package:anavis/widgets/confirm_alert_dialog.dart';
import 'package:anavis/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

class OfficeRequestView extends StatefulWidget {
  final String officeName;
  OfficeRequestView({@required this.officeName});
  @override
  _OfficeRequestViewState createState() => _OfficeRequestViewState();
}

class _OfficeRequestViewState extends State<OfficeRequestView> {
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await Provider.of<CurrentOfficeState>(context).getOfficeRequests();

    _refreshController.refreshCompleted();
  }

  String restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp(r"(\.\d{6})\d+"), (m) => m[1]);

  Future<void> _denyRequest(String requestId, BuildContext context) async {
    return await Provider.of<CurrentOfficeState>(context)
        .denyRequestByID(requestId);
  }

  Future<void> _confirmRequest(String requestId, BuildContext context) async {
    return await Provider.of<CurrentOfficeState>(context)
        .approveRequestByID(requestId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ufficio di ${widget.officeName}",
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
        child: FutureBuilder<List<Request>>(
          future: Provider.of<CurrentOfficeState>(context).getOfficeRequests(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new RequestCircularLoading();
              case ConnectionState.active:
              case ConnectionState.waiting:
                return new RequestCircularLoading();
              case ConnectionState.done:
                if (snapshot.hasError)
                  return new Text("Errore nel recupero dei dati");
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
                        id: snapshot.data[index].getId(),
                        email: snapshot.data[index].getDonorId(),
                        hour: snapshot.data[index].getHour(),
                        buttonBar: ButtonBar(
                          children: <Widget>[
                            ButtonForCardBottom(
                              icon: Icon(
                                Icons.thumb_down,
                                color: Colors.white,
                              ),
                              color: Colors.red,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmAlertDialog(
                                      denyFunction: () {
                                        Navigator.popUntil(context,
                                            ModalRoute.withName('OfficeView'));
                                        Provider.of<AppState>(context)
                                            .showFlushbar(
                                          "Operazione annullata",
                                          "L'operazione è stata annulata correttamente",
                                          false,
                                          context,
                                        );
                                      },
                                      confirmFunction: () {
                                        this
                                            ._denyRequest(
                                                snapshot.data[index].getId(),
                                                context)
                                            .then((_) {
                                          if (Provider.of<CurrentOfficeState>(
                                                  context)
                                              .getStatusBody()) {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'OfficeView'));
                                            Provider.of<AppState>(context)
                                                .showFlushbar(
                                              "Operazione effettuata",
                                              "L'operazione è stata effettuata correttamente",
                                              true,
                                              context,
                                            );
                                          } else {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'OfficeView'));
                                            Provider.of<AppState>(context)
                                                .showFlushbar(
                                              "Operazione non effettuata",
                                              "C'è stato un errore nell'esecuzione dell'operazione",
                                              false,
                                              context,
                                            );
                                          }
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              title: 'Elimina',
                            ),
                            ButtonForCardBottom(
                              icon: Icon(
                                Icons.thumb_up,
                              ),
                              color: Colors.green,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return ConfirmAlertDialog(
                                      denyFunction: () {
                                        Navigator.popUntil(context,
                                            ModalRoute.withName('OfficeView'));
                                        Provider.of<AppState>(context)
                                            .showFlushbar(
                                          "Operazione annullata",
                                          "L'operazione è stata annulata correttamente",
                                          false,
                                          context,
                                        );
                                      },
                                      confirmFunction: () {
                                        this
                                            ._confirmRequest(
                                                snapshot.data[index].getId(),
                                                context)
                                            .then((_) {
                                          if (Provider.of<CurrentOfficeState>(
                                                  context)
                                              .getStatusBody()) {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'OfficeView'));
                                            Provider.of<AppState>(context)
                                                .showFlushbar(
                                              "Operazione effettuata",
                                              "L'operazione è stata effettuata correttamente",
                                              true,
                                              context,
                                            );
                                          } else {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'OfficeView'));
                                            Provider.of<AppState>(context)
                                                .showFlushbar(
                                              "Operazione non effettuata",
                                              "C'è stato un errore nell'esecuzione dell'operazione",
                                              false,
                                              context,
                                            );
                                          }
                                        });
                                      },
                                    );
                                  },
                                );
                              },
                              title: 'Accetta',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              default:
                return new Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Si è verificato un errore di connesione",
                      ),
                    ],
                  ),
                );
            }
          },
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
