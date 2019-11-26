import 'package:anavis/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/app_state.dart';

void main() => runApp(AnAvis());

class AnAvis extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'AnAvis',
        home: ChangeNotifierProvider<AppState>(
          builder: (_) => AppState(),
          child: LoginView(),
        ));
  }
}
