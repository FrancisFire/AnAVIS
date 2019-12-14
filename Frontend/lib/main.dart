import 'package:anavis/models/current_donor_state.dart';
import 'package:anavis/models/current_office_state.dart';
import 'package:anavis/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/app_state.dart';

const String ip = "46.101.201.248";

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
