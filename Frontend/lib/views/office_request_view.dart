import 'package:anavis/model/app_state.dart';
import 'package:anavis/widgets/painter.dart';
import 'package:date_format/date_format.dart';
import 'package:flushbar/flushbar.dart';
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
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    updateReq();
    _refreshController.refreshCompleted();
  }

  void updateReq() {
    setState(() {
      Provider.of<AppState>(context).getOfficeRequestsJson(widget.officeName);
    });
  }

  String restrictFractionalSeconds(String dateTime) =>
      dateTime.replaceFirstMapped(RegExp(r"(\.\d{6})\d+"), (m) => m[1]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ufficio di ${widget.officeName}",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        centerTitle: true,
        elevation: 8,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: CustomPaint(
        painter: Painter(
          first: Colors.red[100],
          second: Colors.orange[200],
          background: Colors.white,
        ),
        child: FutureBuilder<List<dynamic>>(
          future: Provider.of<AppState>(context)
              .getOfficeRequestsJson(widget.officeName),
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
                if (snapshot.data.length == 0) {
                  return new Center(
                    child: Card(
                      elevation: 22,
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(16.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          "Non sono presenti richieste di donazione al momento, si prega di riprovare più tardi",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
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
                  enablePullUp: true,
                  header: WaterDropMaterialHeader(
                    backgroundColor: Colors.red,
                  ),
                  footer: ClassicFooter(
                    idleText: "Trascina verso l'alto per caricare",
                    loadingText: "",
                    canLoadingText: "Rilascia per aggiornare",
                    loadStyle: LoadStyle.ShowAlways,
                    completeDuration: Duration(
                      milliseconds: 500,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return CardRequest(
                        id: snapshot.data[index]['id'],
                        email: snapshot.data[index]['donor']['mail'],
                        hour: formatDate(
                            DateTime.parse(restrictFractionalSeconds(
                              snapshot.data[index]['hour'],
                            )),
                            [
                              "Data: ",
                              dd,
                              '-',
                              mm,
                              '-',
                              yyyy,
                              " | Orario: ",
                              HH,
                              ":",
                              nn
                            ]),
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

class CardRequest extends StatelessWidget {
  final String id;
  final String email;
  final String hour;

  Future<void> _confirmRequest(String requestId, BuildContext context) async {
    return Provider.of<AppState>(context).approveRequestByID(requestId);
  }

  Future<void> _denyRequest(String requestId, BuildContext context) async {
    return Provider.of<AppState>(context).denyRequestByID(requestId);
  }

  CardRequest({
    @required this.id,
    @required this.email,
    @required this.hour,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          right: 12.0,
          left: 12.0,
          top: 4.0,
          bottom: 4.0,
        ),
        child: Card(
          elevation: 16,
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 56,
                ),
                title: Text(email),
                subtitle: Text(
                  hour,
                ),
              ),
              ButtonBarTheme(
                data: ButtonBarThemeData(
                  alignment: MainAxisAlignment.end,
                ),
                child: ButtonBar(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 85.0,
                      ),
                      child: Chip(
                        avatar: CircleAvatar(
                          backgroundColor: Colors.grey.shade800,
                          child: Text(
                            'ID',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        label: Text(
                          id,
                        ),
                      ),
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(26.0),
                        ),
                      ),
                      color: Colors.red,
                      child: const Text(
                        'Rifiuta',
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmAlertDialog(
                              confirmFunction: () {
                                this._denyRequest(id, context);
                                Navigator.popUntil(
                                    context, ModalRoute.withName('OfficeView'));
                                //Navigator.pop(context);
                                Flushbar(
                                  margin: EdgeInsets.all(8),
                                  borderRadius: 26,
                                  shouldIconPulse: true,
                                  title: "Operazione confermata",
                                  icon: Icon(
                                    Icons.check,
                                    size: 28.0,
                                    color: Colors.green[600],
                                  ),
                                  message:
                                      "L'operazione è stata confermata correttamente",
                                  duration: Duration(
                                    seconds: 6,
                                  ),
                                  isDismissible: true,
                                  dismissDirection:
                                      FlushbarDismissDirection.HORIZONTAL,
                                ).show(context);
                              },
                            );
                          },
                        );
                      },
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(26.0),
                        ),
                      ),
                      color: Colors.green,
                      child: const Text(
                        'Accetta',
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return ConfirmAlertDialog(
                              confirmFunction: () {
                                this._confirmRequest(id, context);
                                Navigator.popUntil(
                                    context, ModalRoute.withName('OfficeView'));
                                //Navigator.pop(context);
                                Flushbar(
                                  margin: EdgeInsets.all(8),
                                  borderRadius: 26,
                                  shouldIconPulse: true,
                                  title: "Operazione confermata",
                                  icon: Icon(
                                    Icons.check,
                                    size: 28.0,
                                    color: Colors.green[600],
                                  ),
                                  message:
                                      "L'operazione è stata confermata correttamente",
                                  duration: Duration(
                                    seconds: 6,
                                  ),
                                  isDismissible: true,
                                  dismissDirection:
                                      FlushbarDismissDirection.HORIZONTAL,
                                ).show(context);
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
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
    return Center(
        child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
      Colors.red,
    )));
  }
}

class ConfirmAlertDialog extends StatelessWidget {
  final Function confirmFunction;
  ConfirmAlertDialog({
    @required this.confirmFunction,
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(26.0),
        ),
      ),
      content: Text("Confermare la scelta?"),
      actions: <Widget>[
        new FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(26.0),
            ),
          ),
          child: Text("Annulla"),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('OfficeView'));
            //Navigator.pop(context);
            Flushbar(
              margin: EdgeInsets.all(8),
              borderRadius: 26,
              shouldIconPulse: true,
              title: "Operazione annullata",
              icon: Icon(
                Icons.info_outline,
                size: 28.0,
                color: Colors.red[600],
              ),
              message: "L'operazione è stata annulata correttamente",
              duration: Duration(
                seconds: 6,
              ),
              isDismissible: true,
              dismissDirection: FlushbarDismissDirection.HORIZONTAL,
            ).show(context);
          },
          color: Colors.red,
        ),
        new FlatButton(
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(26.0),
            ),
          ),
          child: Text("Conferma"),
          onPressed: confirmFunction,
          color: Colors.green,
        ),
      ],
    );
  }
}
