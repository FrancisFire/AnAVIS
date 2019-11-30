import 'package:anavis/model/app_state.dart';
import 'package:anavis/widgets/painter.dart';
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
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Rubik',
        accentColor: Colors.red[400],
        accentColorBrightness: Brightness.light,
      ),
      home: Scaffold(
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
          child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
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
                      return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return CardRequest(
                            id: snapshot.data[index]['id'],
                            email: snapshot.data[index]['donor']['mail'],
                            hour: snapshot.data[index]['hour'],
                          );
                        },
                      );
                  }
                },
              )),
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
    await Provider.of<AppState>(context).approveRequestByID(requestId);
  }

  Future<void> _denyRequest(String requestId, BuildContext context) async {
    await Provider.of<AppState>(context).denyRequestByID(requestId);
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

                                  Navigator.pop(context);
                                  Flushbar(
                                    message: "La scelta è stata confermata",
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                },
                              );
                            });
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

                                  Navigator.pop(context);
                                  Flushbar(
                                    message: "La scelta è stata confermata",
                                    duration: Duration(seconds: 3),
                                  ).show(context);
                                },
                              );
                            });
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
  Function confirmFunction;
  ConfirmAlertDialog({@required this.confirmFunction});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text("Confermare la scelta?"),
      actions: <Widget>[
        new FlatButton(
          child: Text("Annulla"),
          onPressed: () {
            Navigator.pop(context);
            Flushbar(
              message: "La scelta è stata annullata",
              duration: Duration(seconds: 3),
            ).show(context);
          },
          color: Colors.red,
        ),
        new FlatButton(
          child: Text("Conferma"),
          onPressed: confirmFunction,
          color: Colors.green,
        ),
      ],
    );
  }
}
