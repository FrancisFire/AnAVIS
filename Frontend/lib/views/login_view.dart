import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/services/authcredentials_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        return 'Login non valido';
      } else {
        AppState().setUserMail(data.name);
        AppState().setPass(data.password);
        AppState().setRole(role);
        return null;
      }
    });
  }

  LoginMessages msg() {
    return LoginMessages(
      usernameHint: 'Email',
      passwordHint: 'Password',
      confirmPasswordHint: 'Conferma',
      loginButton: 'LOGIN',
      signupButton: 'REGISTRATI',
      forgotPasswordButton: 'Password dimenticata?',
      recoverPasswordButton: 'INVIA MAIL',
      goBackButton: 'INDIETRO',
      confirmPasswordError: 'Non corrispondono le due password!',
      recoverPasswordDescription:
          "Digita l'email con la quale ti sei registrato al servizio e ti invieremo una mail di ripristino",
      recoverPasswordSuccess: 'Password rescued successfully',
      recoverPasswordIntro: 'Reimposta la tua password qui',
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ),
    );
    return Scaffold(
      body: FlutterLogin(
        theme: LoginTheme(
          primaryColor: Colors.red,
          accentColor: Colors.red[600],
          buttonStyle: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          errorColor: Colors.deepOrange,
          titleStyle: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 68,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        title: 'AnAVIS',
        onLogin: _authUser,
        onSignup: (_) {},
        emailValidator: (value) {
          return value.isEmpty ? 'Email inserita non valida' : null;
        },
        passwordValidator: (value) {
          return value.isEmpty ? 'Password inserita non valida' : null;
        },
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
        messages: msg(),
        onRecoverPassword: (_) {},
      ),
    );
  }
}
