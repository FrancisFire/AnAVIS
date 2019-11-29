import 'package:flutter/material.dart';

class OfficeRequestView extends StatefulWidget {
  @override
  _OfficeRequestViewState createState() => _OfficeRequestViewState();
}

class _OfficeRequestViewState extends State<OfficeRequestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Ufficio di Osimo",
          style: TextStyle(
            color: Colors.red,
          ),
        ),
        centerTitle: true,
        elevation: 16,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Stack(children: <Widget>[
        ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return CardRequest();
          },
        ),
      ]),
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
          top: 3.0,
          bottom: 3.0,
        ),
        child: Card(
          elevation: 22,
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
