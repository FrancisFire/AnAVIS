import 'package:anavis/providers/app_state.dart';
import 'package:anavis/providers/current_donor_state.dart';
import 'package:anavis/providers/current_office_state.dart';
import 'package:anavis/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

const String ip = "192.168.1.127";

void main() {
  initializeDateFormatting().then((_) => runApp(AnAvis()));
}

class AnAvis extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppState>(
          builder: (_) => AppState(ip),
        ),
        ChangeNotifierProvider<CurrentDonorState>(
          builder: (_) => CurrentDonorState(ip),
        ),
        ChangeNotifierProvider<CurrentOfficeState>(
          builder: (_) => CurrentOfficeState(ip),
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
