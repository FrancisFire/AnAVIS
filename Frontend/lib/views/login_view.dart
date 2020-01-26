import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/services/authcredentials_service.dart';
import 'package:anavis/viewargs/guest_create_donor_args.dart';
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
      body: Stack(
        children: [
          FlutterLogin(
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
            onSignup: (LoginData loginData) {
              Navigator.of(context).pushReplacementNamed(
                '/guest/createuser',
                arguments: GuestCreateDonorArgs(
                  loginData.name,
                  loginData.password,
                ),
              );
            },
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
          Positioned(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton.icon(
                      icon: Icon(
                        Icons.chat,
                        color: Colors.red,
                        size: 22,
                      ),
                      label: Text(
                        "F.A.Q",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('F.A.Q'),
                              shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              content: const Text('Domanda e risposta'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    'Chiudi',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      color: Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    RaisedButton.icon(
                      icon: Icon(
                        Icons.screen_lock_portrait,
                        color: Colors.red,
                        size: 22,
                      ),
                      label: Text(
                        "Privacy",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      onPressed: () {
                        return showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Privacy'),
                              shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              content: const Text('Informativa'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text(
                                    'Ho capito',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      color: Colors.white,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              left: 16,
              right: 16,
              bottom: 16),
        ],
      ),
    );
  }
}
