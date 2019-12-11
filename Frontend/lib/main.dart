import 'package:anavis/model/current_donor_state.dart';
import 'package:anavis/model/current_office_state.dart';
import 'package:anavis/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/app_state.dart';

const String ip = "10.0.12.144";
void main() => runApp(AnAvis());

class AnAvis extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
          create: (_) => AppState(ip),
        ),
        ChangeNotifierProvider<CurrentDonorState>(
          create: (_) => CurrentDonorState(ip),
        ),
        ChangeNotifierProvider<CurrentOfficeState>(
          create: (_) => CurrentOfficeState(ip),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
