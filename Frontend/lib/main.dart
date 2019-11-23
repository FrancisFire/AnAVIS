import 'package:anavis/pages/donor_avis.dart';
import 'package:anavis/pages/office_avis.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

void main() => runApp(Homepage());

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Rubik',
        primaryColor: Colors.white,
      ),
      home: CardLogin(controller: _controller),
    );
  }
}

class CardLogin extends StatelessWidget {
  const CardLogin({
    Key key,
    @required TabController controller,
  })  : _controller = controller,
        super(key: key);

  final TabController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Flex(
            direction: Axis.vertical,
            children: <Widget>[
              Flexible(
                flex: 10,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 24,
                    ),
                    Text(
                      "AnAVIS",
                      style: TextStyle(
                        fontSize: 64,
                        color: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    AutoSizeText(
                      "Il futuro è una questione di sangue",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 25,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 26,
                    right: 26,
                    bottom: 26,
                  ),
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(26.0),
                      ),
                    ),
                    elevation: 28,
                    child: Column(
                      children: <Widget>[
                        Theme(
                          data: ThemeData(
                            fontFamily: 'Rubik',
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          child: TabBar(
                            controller: _controller,
                            labelColor: Colors.red,
                            indicatorColor: Colors.redAccent,
                            labelPadding: EdgeInsets.all(18.0),
                            tabs: <Widget>[
                              Text("Donatore AVIS"),
                              Text("Ufficio AVIS"),
                            ],
                          ),
                        ),
                        Expanded(
                          child: TabBarView(
                            controller: _controller,
                            children: [
                              RaisedButton(
                                child: Icon(Icons.face),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return DonorAvis();
                                  }));
                                },
                              ),
                              RaisedButton(
                                child: Icon(Icons.face),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return OfficeAvis();
                                  }));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
