import 'package:anavis/views/widgets/button_card_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class AdminView extends StatefulWidget {
  @override
  _AdminViewState createState() => _AdminViewState();
}

class _AdminViewState extends State<AdminView> {
  final pages = [
    Container(
      color: Colors.red[600],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                'assets/images/user.svg',
                fit: BoxFit.cover,
                width: 300,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          "Aggiungi utente",
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          "Inserisci le credenziali relative a un nuovo utente",
                          style: TextStyle(fontSize: 16),
                        ),
                        leading: Icon(
                          Icons.supervised_user_circle,
                          size: 40,
                        ),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          ButtonForCardBottom(
                            icon: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            color: Colors.grey,
                            onTap: () {},
                            title: 'Torna alla home',
                          ),
                          ButtonForCardBottom(
                            icon: Icon(
                              Icons.add_circle,
                            ),
                            color: Colors.deepOrangeAccent,
                            onTap: () {},
                            title: 'Aggiungi',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 42,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Text(
                  "Effettua uno swipe laterale per accedere a un contenuto differente",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey[100],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
    Container(
      color: Colors.grey[350],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 42),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: SvgPicture.asset(
                'assets/images/data.svg',
                fit: BoxFit.cover,
                width: 300,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Card(
                  elevation: 12,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.all(16),
                        title: Text(
                          "Amministra utenti",
                          style: TextStyle(fontSize: 18),
                        ),
                        subtitle: Text(
                          "Effettua delle operazioni di amministrazione sugli utenti",
                          style: TextStyle(fontSize: 16),
                        ),
                        leading: Icon(
                          Icons.tune,
                          size: 40,
                        ),
                      ),
                      ButtonBar(
                        children: <Widget>[
                          ButtonForCardBottom(
                            icon: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            color: Colors.grey,
                            onTap: () {},
                            title: 'Torna alla home',
                          ),
                          ButtonForCardBottom(
                            icon: Icon(
                              Icons.remove_red_eye,
                            ),
                            color: Colors.indigoAccent,
                            onTap: () {},
                            title: 'Visualizza',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 42,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Text(
                  "Effettua uno swipe laterale per accedere a un contenuto differente",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.indigo,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        fullTransitionValue: 500,
        enableSlideIcon: false,
        enableLoop: true,
      ),
    );
  }
}

// class PagesSwiper extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final String pathSVG;
//   final Icon iconCard;
//   final ButtonForCardBottom button;

//   PagesSwiper({
//     @required this.title,
//     @required this.subtitle,
//     @required this.pathSVG,
//     @required this.iconCard,
//     @required this.button,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.pinkAccent,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 42),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: <Widget>[
//             Container(
//               child: SvgPicture.asset(
//                 this.pathSVG,
//                 fit: BoxFit.cover,
//                 width: 300,
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18),
//                 child: Card(
//                   elevation: 12,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(12.0),
//                     ),
//                   ),
//                   child: Column(
//                     children: <Widget>[
//                       ListTile(
//                         contentPadding: EdgeInsets.all(16),
//                         title: Text(
//                           this.title,
//                           style: TextStyle(fontSize: 18),
//                         ),
//                         subtitle: Text(
//                           this.subtitle,
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         leading: Icon(
//                           Icons.supervised_user_circle,
//                           size: 40,
//                         ),
//                       ),
//                       ButtonBar(
//                         children: <Widget>[
//                           ButtonForCardBottom(
//                             icon: Icon(
//                               Icons.home,
//                             ),
//                             color: Colors.grey,
//                             onTap: () {},
//                             title: 'Torna alla home',
//                           ),
//                           this.button,
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 26),
//                 child: Text(
//                   "Effettua uno swipe laterale per accedere a un contenuto differente",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontStyle: FontStyle.italic,
//                     color: Colors.grey[100],
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
