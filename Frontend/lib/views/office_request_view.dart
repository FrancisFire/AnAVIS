import 'package:anavis/models/office.dart';
import 'package:anavis/models/requestprenotation.dart';
import 'package:anavis/services/request_service.dart';
import 'package:anavis/views/widgets/button_card_bottom.dart';
import 'package:anavis/views/widgets/card_prenotation_request.dart';
import 'package:anavis/views/widgets/confirm_alert_dialog.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:anavis/views/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OfficeRequestView extends StatefulWidget {
  final Office office;
  OfficeRequestView({@required this.office});
  @override
  _OfficeRequestViewState createState() => _OfficeRequestViewState();
}

class _OfficeRequestViewState extends State<OfficeRequestView> {
  List<RequestPrenotation> _requests;
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await this.getRequests();

    _refreshController.refreshCompleted();
  }

  String restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp(r"(\.\d{6})\d+"), (m) => m[1]);

  Future<void> getRequests() async {
    _requests = await RequestService(context)
        .getRequestsByOffice(widget.office.getMail());
  }

  Future<void> initFuture() async {
    await Future.wait([
      this.getRequests(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ufficio di ${widget.office.getPlace()}",
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
        child: FutureBuilder(
          future: this.initFuture(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new RequestCircularLoading();
              case ConnectionState.active:
              case ConnectionState.waiting:
                return new RequestCircularLoading();
              case ConnectionState.done:
                if (_requests.isEmpty) {
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
                    itemCount: _requests.length,
                    itemBuilder: (context, index) {
                      return CardForPrenotationAndRequest(
                        id: _requests[index].getId(),
                        email: _requests[index].getDonorMail(),
                        hour: _requests[index].getHour(),
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
                                        ConfirmationFlushbar(
                                          "Operazione annullata",
                                          "L'operazione è stata annulata correttamente",
                                          false,
                                        ).show(context);
                                      },
                                      confirmFunction: () {
                                        RequestService(context)
                                            .denyRequest(
                                                _requests[index].getId())
                                            .then((status) {
                                          if (status) {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'OfficeView'));
                                            ConfirmationFlushbar(
                                              "Operazione effettuata",
                                              "L'operazione è stata effettuata correttamente",
                                              true,
                                            ).show(context);
                                          } else {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'OfficeView'));
                                            ConfirmationFlushbar(
                                              "Operazione non effettuata",
                                              "C'è stato un errore nell'esecuzione dell'operazione",
                                              false,
                                            ).show(context);
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
                                        ConfirmationFlushbar(
                                          "Operazione annullata",
                                          "L'operazione è stata annulata correttamente",
                                          false,
                                        ).show(context);
                                      },
                                      confirmFunction: () {
                                        RequestService(context)
                                            .approveRequest(
                                                _requests[index].getId())
                                            .then((status) {
                                          if (status) {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'OfficeView'));
                                            ConfirmationFlushbar(
                                              "Operazione effettuata",
                                              "L'operazione è stata effettuata correttamente",
                                              true,
                                            ).show(context);
                                          } else {
                                            Navigator.popUntil(
                                                context,
                                                ModalRoute.withName(
                                                    'OfficeView'));
                                            ConfirmationFlushbar(
                                              "Operazione non effettuata",
                                              "C'è stato un errore nell'esecuzione dell'operazione",
                                              false,
                                            ).show(context);
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
