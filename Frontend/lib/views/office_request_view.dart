import 'package:anavis/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OfficeRequestView extends StatefulWidget {
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
            "Ufficio di Osimo",
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
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return CardRequest();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CardRequest extends StatelessWidget {
  final String id;
  final String email;
  final String hour;

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
              const ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 56,
                ),
                title: Text(
                  'francesco@mail.com',
                ),
                subtitle: Text(
                  '1970-01-01T00:04:40.000+0000',
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
                          'Numero',
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
                      onPressed: () {},
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
                      onPressed: () {},
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
