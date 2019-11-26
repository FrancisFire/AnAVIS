import 'package:anavis/views/donor_view.dart';
import 'package:anavis/views/office_view.dart';
import 'package:anavis/widgets/card_painter.dart';
import 'package:anavis/widgets/login_form.dart';
import 'package:anavis/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
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
        painter: Painter(
          first: Colors.red[100],
          second: Colors.orange[200],
          background: Colors.white,
        ),
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
                                              return DonorView();
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
                                              return OfficeView();
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
