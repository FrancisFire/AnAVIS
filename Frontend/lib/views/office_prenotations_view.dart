import 'package:anavis/models/app_state.dart';
import 'package:anavis/models/current_office_state.dart';
import 'package:anavis/models/prenotation.dart';
import 'package:anavis/widgets/button_card_bottom.dart';
import 'package:anavis/widgets/card_prenotation_request.dart';
import 'package:anavis/widgets/confirm_alert_dialog.dart';
import 'package:anavis/widgets/custom_dialog_mod_prenotation.dart';
import 'package:anavis/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OfficePrenotationView extends StatefulWidget {
  @override
  _OfficePrenotationViewState createState() => _OfficePrenotationViewState();
}

class _OfficePrenotationViewState extends State<OfficePrenotationView> {
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await Provider.of<CurrentOfficeState>(context).getOfficePrenotations();
    _refreshController.refreshCompleted();
  }

  Future<void> _removePrenotation(
      String prenotationId, BuildContext context) async {
    return await Provider.of<CurrentOfficeState>(context)
        .removePrenotationByID(prenotationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Prenotazioni per ${Provider.of<CurrentOfficeState>(context).getOfficeName()}",
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
            future: Provider.of<CurrentOfficeState>(context)
                .getOfficePrenotations(),
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
                              "Non sono presenti prenotazioni di donazione al momento, si prega di riprovare più tardi",
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
                          email: snapshot.data[index].getDonorId(),
                          hour: snapshot.data[index].getHour(),
                          id: snapshot.data[index].getId(),
                          buttonBar: ButtonBar(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: snapshot.data[index].isConfirmed()
                                    ? Icon(
                                        Icons.check_circle,
                                        size: 38,
                                        color: Colors.green,
                                      )
                                    : Icon(
                                        Icons.error,
                                        size: 38,
                                        color: Colors.red,
                                      ),
                              ),
                              ButtonForCardBottom(
                                icon: Icon(
                                  Icons.mode_edit,
                                  color: Colors.white,
                                ),
                                color: Colors.orange,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DialogModificationPrenotation(
                                      prenotationId:
                                          snapshot.data[index].getId(),
                                      donor: snapshot.data[index].getDonorId(),
                                    ),
                                  );
                                },
                                title: 'Modifica',
                              ),
                              ButtonForCardBottom(
                                icon: Icon(
                                  Icons.cancel,
                                ),
                                color: Colors.red,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ConfirmAlertDialog(
                                        denyFunction: () {
                                          Navigator.popUntil(
                                              context,
                                              ModalRoute.withName(
                                                  'OfficeView'));
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
                                              ._removePrenotation(
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
