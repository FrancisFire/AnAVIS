import 'package:anavis/models/requestprenotation.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/providers/current_donor_state.dart';
import 'package:anavis/services/request_service.dart';
import 'package:anavis/views/widgets/button_card_bottom.dart';
import 'package:anavis/views/widgets/card_prenotation_request.dart';
import 'package:anavis/views/widgets/delete_dialog.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:anavis/views/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DonorRequestView extends StatefulWidget {
  @override
  _DonorRequestViewState createState() => _DonorRequestViewState();
}

class _DonorRequestViewState extends State<DonorRequestView> {
  List<RequestPrenotation> _requests;
  String _mail;
  RequestService _requestService;
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await this.getRequests();
    _refreshController.refreshCompleted();
  }

  Future<List<RequestPrenotation>> getRequests() async {
    _requests = await _requestService.getRequestsByDonor(this._mail);
    return _requests;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _requestService = new RequestService(context);
    _mail = Provider.of<AppState>(context).getUserMail();
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
            future: this.getRequests(),
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
