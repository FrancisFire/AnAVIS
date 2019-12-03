import 'package:anavis/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/app_state.dart';

void main() => runApp(AnAvis());

class AnAvis extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      child: MaterialApp(
        theme: ThemeData(
          fontFamily: 'Rubik',
          accentColor: Colors.orangeAccent[400],
          accentColorBrightness: Brightness.light,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/',
      ),
    );
  }
}
