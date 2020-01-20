import 'package:anavis/models/activeprenotation.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/services/prenotation_service.dart';
import 'package:anavis/views/widgets/button_card_bottom.dart';
import 'package:anavis/views/widgets/card_prenotation_request.dart';
import 'package:anavis/views/widgets/donor_delete_dialog.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:anavis/views/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DonorPrenotationView extends StatefulWidget {
  final Donor donor;
  DonorPrenotationView({@required this.donor});
  @override
  _DonorPrenotationViewState createState() => _DonorPrenotationViewState();
}

class _DonorPrenotationViewState extends State<DonorPrenotationView> {
  List<ActivePrenotation> _donorPrenotations;
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await this.getPrenotations();
    _refreshController.refreshCompleted();
  }

  Future<void> initFuture() async {
    await Future.wait([
      this.getPrenotations(),
    ]);
  }

  Future<void> getPrenotations() async {
    _donorPrenotations = await PrenotationService(context)
        .getPrenotationsByDonor(widget.donor.getMail());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Le tue prenotazioni attive",
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
                  if (snapshot.hasError) return new RequestCircularLoading();
                  if (_donorPrenotations.isEmpty) {
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
                      itemCount: _donorPrenotations.length,
                      itemBuilder: (context, index) {
                        return CardForPrenotationAndRequest(
                          email: _donorPrenotations[index].getOfficeMail(),
                          hour: _donorPrenotations[index].getHour(),
                          id: _donorPrenotations[index].getId(),
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
                                        DonorDeleteDialog(
                                      id: _donorPrenotations[index].getId(),
                                      isPrenotation: true,
                                      title: "Elimina prenotazione",
                                      subtitle:
                                          "Puoi eliminare la prenotazione effettuata",
                                    ),
                                  );
                                },
                                title: 'Cancella prenotazione',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
