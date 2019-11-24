import 'package:anavis/pages/donor_avis.dart';
import 'package:anavis/pages/office_avis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: CustomPaint(
        painter: RedPainter(),
        child: Stack(
          children: <Widget>[
            Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              verticalDirection: VerticalDirection.down,
              textDirection: TextDirection.ltr,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 22,
                          bottom: 18,
                        ),
                        child: Text(
                          "AnAVIS",
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 64,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            backgroundColor: Colors.red,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        "Il futuro è una questione di sangue",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.red,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 3,
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
                      elevation: 5,
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
                                Text(
                                  "Donatore AVIS",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Ufficio AVIS",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              controller: _controller,
                              children: [
                                ScrollConfiguration(
                                  behavior: RemoveGlow(),
                                  child: SingleChildScrollView(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(24.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text(
                                                "Inserisci la tua email",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            BeautyTextfield(
                                              width: double.maxFinite,
                                              height: 60,
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              inputType: TextInputType.text,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.red[200],
                                              cornerRadius: BorderRadius.all(
                                                Radius.circular(
                                                  26.0,
                                                ),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.account_circle,
                                              ),
                                              placeholder: "Email",
                                              onTap: () {
                                                print('Click');
                                              },
                                              onChanged: (t) {
                                                print(t);
                                              },
                                              onSubmitted: (d) {
                                                print(d.length);
                                              },
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0),
                                              child: Text(
                                                "Inserisci la tua password",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                            BeautyTextfield(
                                              width: double.maxFinite,
                                              height: 60,
                                              duration: Duration(
                                                milliseconds: 300,
                                              ),
                                              inputType: TextInputType.text,
                                              backgroundColor: Colors.red,
                                              textColor: Colors.red[200],
                                              cornerRadius: BorderRadius.all(
                                                Radius.circular(
                                                  26.0,
                                                ),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.lock,
                                              ),
                                              placeholder: "Password",
                                              onTap: () {
                                                print('Click');
                                              },
                                              onChanged: (t) {
                                                print(t);
                                              },
                                              onSubmitted: (d) {
                                                print(d.length);
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 24.0,
                                              ),
                                              child: Center(
                                                child: SizedBox(
                                                  height: 50,
                                                  child: RaisedButton.icon(
                                                    onPressed: () {
                                                      Navigator.push(context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) {
                                                        return DonorAvis();
                                                      }));
                                                    },
                                                    elevation: 18.0,
                                                    icon: Icon(
                                                      FontAwesomeIcons.tint,
                                                      color: Colors.red,
                                                    ),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                        Radius.circular(26.0),
                                                      ),
                                                    ),
                                                    color: Colors.white,
                                                    label: Text(
                                                      "Effettua il login",
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 20.0,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
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
      ),
    );
  }
}

class RemoveGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class RedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final height = size.height;
    final width = size.width;
    Paint paint = Paint();

    Path mainBackground = Path();
    mainBackground.addRect(
      Rect.fromLTRB(0, 0, width, height),
    );
    paint.color = Colors.white;
    canvas.drawPath(mainBackground, paint);

    Path ovalPath = Path();
    // Start paint from 20% height to the left
    ovalPath.moveTo(0, height * 0.2);

    // paint a curve from current position to middle of the screen
    ovalPath.quadraticBezierTo(
        width * 0.45, height * 0.25, width * 0.51, height * 0.5);

    // Paint a curve from current position to bottom left of screen at width * 0.1
    ovalPath.quadraticBezierTo(width * 0.58, height * 0.8, width * 0.1, height);

    // draw remaining line to bottom left side
    ovalPath.lineTo(0, height);

    // Close line to reset it back
    ovalPath.close();

    paint.color = Colors.red[100];
    canvas.drawPath(ovalPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
