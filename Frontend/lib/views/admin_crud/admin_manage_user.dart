import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/services/authcredentials_service.dart';
import 'package:anavis/views/widgets/button_card_bottom.dart';
import 'package:anavis/views/widgets/card_prenotation_request.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:anavis/views/widgets/login_form.dart';
import 'package:anavis/views/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AdminManageUserView extends StatefulWidget {
  @override
  _AdminManageUserViewState createState() => _AdminManageUserViewState();
}

class _AdminManageUserViewState extends State<AdminManageUserView> {
  List<AuthCredentials> _listAuth;
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await this.getAuth();
    _refreshController.refreshCompleted();
  }

  Future<void> getAuth() async {
    _listAuth = await AuthCredentialsService(context).getAuthCredentials();
  }

  Future<void> initFuture() async {
    await Future.wait([
      this.getAuth(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Amministrazione utenti",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 8,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.indigo,
      ),
      body: CustomPaint(
        painter: Painter(
          background: Colors.white,
          first: Colors.orange[200],
          second: Colors.indigo[700],
        ),
        child: FutureBuilder(
          future: initFuture(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new RequestCircularLoading();
              case ConnectionState.active:
              case ConnectionState.waiting:
                return new RequestCircularLoading();
              case ConnectionState.done:
                if (snapshot.hasError) return new RequestCircularLoading();
                if (_listAuth.isEmpty) {
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
                            "Non sono presenti utenti al momento, si prega di riprovare più tardi",
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
                    backgroundColor: Colors.indigo[900],
                  ),
                  child: ListView.builder(
                    itemCount: _listAuth.length,
                    itemBuilder: (context, index) {
                      return CardForPrenotationAndRequest(
                        email: _listAuth[index].getMail(),
                        hour: _listAuth[index].getPassword(),
                        id: "ID",
                        buttonBar: ButtonBar(
                          children: <Widget>[
                            ButtonForCardBottom(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              color: Colors.red,
                              onTap: () {},
                              title: 'Elimina',
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
            }
            return null;
            //         child: ScrollConfiguration(
            //   behavior: RemoveGlow(),
            //   child: ListView(
            //     children: <Widget>[
            //       Text("data"),
            //       Text("data"),
            //     ],
            //   ),
            // ),
          },
        ),
      ),
    );
  }
}
