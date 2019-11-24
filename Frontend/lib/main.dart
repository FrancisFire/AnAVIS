import 'package:anavis/pages/donor_avis.dart';
import 'package:anavis/pages/office_avis.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'components/login_form.dart';

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
                  child: ScrollConfiguration(
                    behavior: RemoveGlow(),
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      reverse: true,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                              top: 80.0,
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
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24.0,
                            ),
                            child: TypewriterAnimatedTextKit(
                              text: [
                                "Il futuro è una questione di sangue",
                                "Ogni goccia di sangue fa la differenza",
                                "Dona oggi per ricevere un domani",
                                "Condividi il meglio di te agli altri",
                              ],
                              textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                              textAlign: TextAlign.center,
                              alignment: AlignmentDirectional.center,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 18.0,
                              bottom: 18.0,
                            ),
                            child: Image.asset(
                              'assets/images/divider.png',
                              height: 34,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      elevation: 7,
                      child: ClipRRect(
                        borderRadius: new BorderRadius.circular(26.0),
                        child: CustomPaint(
                          painter: CardPainter(),
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
                                    LoginForm(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return DonorAvis();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    LoginForm(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return OfficeAvis();
                                            },
                                          ),
                                        );
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

    Path ovalPathRight = Path();
    Path ovalPathLeft = Path();

    ovalPathRight.moveTo(0, height * 0.2);
    ovalPathRight.quadraticBezierTo(
        width * 0.45, height * 0.25, width * 0.51, height * 0.5);
    ovalPathRight.quadraticBezierTo(
        width * 0.58, height * 0.8, width * 0.1, height);
    ovalPathRight.lineTo(0, height);
    ovalPathRight.close();

    ovalPathLeft.moveTo(height / 2, 0);
    ovalPathLeft.quadraticBezierTo(
        width * 0.18, height * 0.5, width * 1.5, height * 0.8);
    ovalPathLeft.quadraticBezierTo(
        width * 9, height * 0.13, width * 1.4, height);
    ovalPathLeft.lineTo(height, 0);
    ovalPathLeft.close();

    paint.color = Colors.red[100];

    canvas.drawPath(ovalPathRight, paint);

    paint.color = Colors.orange[200];

    canvas.drawPath(ovalPathLeft, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}

class CardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red[300];
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
