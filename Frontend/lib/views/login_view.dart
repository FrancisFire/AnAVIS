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
  AuthCredentials _newCredentials;
  bool _newDonor;
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
        _newDonor = false;
        return null;
      }
    });
  }

  Future<String> _newUser(LoginData login) async {
    _newCredentials =
        new AuthCredentials.complete(login.name, login.password, Role.DONOR);
    _newDonor = true;

    return null;
  }

  LoginMessages msg() {
    return LoginMessages(
      usernameHint: 'Email',
      passwordHint: 'Password',
      confirmPasswordHint: 'Conferma la password',
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
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
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
            fontSize: 48,
            color: Colors.white,
            letterSpacing: 2,
          ),
        ),
        title: 'AnAVIS',
        onLogin: _authUser,
        logo: 'assets/images/homepage_login.png',
        onSignup: _newUser,
        emailValidator: (value) {
          return value.isEmpty ? 'Email inserita non valida' : null;
        },
        passwordValidator: (value) {
          return value.isEmpty ? 'Password inserita non valida' : null;
        },
        onSubmitAnimationCompleted: () {
          if (_newDonor) {
            Navigator.of(context).pushReplacementNamed(
              '/guest/createuser',
              arguments: this._newCredentials,
            );
          } else {
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
          }
        },
        messages: msg(),
        onRecoverPassword: (_) {},
      ),
    );
  }
}
