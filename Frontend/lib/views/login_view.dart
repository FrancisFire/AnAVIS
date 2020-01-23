import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/services/authcredentials_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Future<String> _authUser(LoginData data) {
    AuthCredentials auth = new AuthCredentials(data.name);
    auth.setPassword(data.password);
    return AuthCredentialsService(context)
        .loginWithCredentials(auth)
        .then((role) {
      if (role == null) {
        print(role);
        return 'Login non valido';
      } else {
        AppState().setUserMail(data.name);
        AppState().setPass(data.password);
        AppState().setRole(role);
        print(role);
        return null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'AnAVIS',
      onLogin: _authUser,
      onSignup: (_) {},
      onSubmitAnimationCompleted: () {
        switch (AppState().getRole()) {
          case Role.DONOR:
            Navigator.of(context).pushReplacementNamed("/donor");
            break;
          case Role.OFFICE:
            Navigator.of(context).pushReplacementNamed("/office");
            break;
          case Role.ADMIN:
            Navigator.of(context).pushReplacementNamed("/admin");
            break;
        }
      },
      onRecoverPassword: (_) {},
    );
  }
}
