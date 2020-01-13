import 'package:anavis/providers/current_donor_state.dart';
import 'package:anavis/models/prenotation.dart';
import 'package:anavis/widgets/button_card_bottom.dart';
import 'package:anavis/widgets/card_prenotation_request.dart';
import 'package:anavis/widgets/delete_dialog.dart';
import 'package:anavis/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DonorPrenotationView extends StatefulWidget {
  @override
  _DonorPrenotationViewState createState() => _DonorPrenotationViewState();
}

class _DonorPrenotationViewState extends State<DonorPrenotationView> {
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
          child: FutureBuilder<List<Prenotation>>(
            future: Provider.of<CurrentDonorState>(context)
                .getDonorActivePrenotations(),
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
                                      prenotationId:
                                          snapshot.data[index].getId(),
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
