import 'package:anavis/models/requestprenotation.dart';
import 'package:anavis/providers/current_donor_state.dart';
import 'package:anavis/widgets/button_card_bottom.dart';
import 'package:anavis/widgets/card_prenotation_request.dart';
import 'package:anavis/widgets/delete_dialog.dart';
import 'package:anavis/widgets/loading_circluar.dart';
import 'package:anavis/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DonorRequestView extends StatefulWidget {
  @override
  _DonorRequestViewState createState() => _DonorRequestViewState();
}

class _DonorRequestViewState extends State<DonorRequestView> {
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await Provider.of<CurrentDonorState>(context).getDonorActivePrenotations();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Le tue richieste attive",
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
          child: FutureBuilder<List<RequestPrenotation>>(
            future: Provider.of<CurrentDonorState>(context).getDonorRequests(),
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
                              "Non sono presenti richieste di donazione al momento, si prega di aggiungerne per visualizzarle",
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
                          email: snapshot.data[index].getOfficeMail(),
                          hour: snapshot.data[index].getHour(),
                          id: snapshot.data[index].getId(),
                          buttonBar: ButtonBar(
                            children: <Widget>[
                              ButtonForCardBottom(
                                icon: Icon(
                                  Icons.cancel,
                                ),
                                color: Colors.deepOrangeAccent,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DeleteDialog(
                                      id: snapshot.data[index].getId(),
                                      isPrenotation: false,
                                      title: "Elimina richiesta",
                                      subtitle:
                                          "Puoi eliminare la richiesta effettuata in precendenza",
                                    ),
                                  );
                                },
                                title: 'Cancella richiesta',
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
