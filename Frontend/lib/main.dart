import 'package:anavis/providers/app_state.dart';
import 'package:anavis/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

const String ip = "10.0.4.235";

void main() {
  initializeDateFormatting().then((_) => runApp(AnAvis()));
}

class AnAvis extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppState().setIpReference(ip);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Rubik',
        accentIconTheme: IconThemeData(
          color: Colors.white,
        ),
        accentColor: Colors.orangeAccent[400],
        accentColorBrightness: Brightness.light,
      ),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
