import 'package:anavis/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final Function onTap;

  LoginForm({
    @required this.onTap,
  });

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    Provider.of<AppState>(context).setEmail('coppola@mail.com');
    Provider.of<AppState>(context).setOffice('Osimo');

    return ScrollConfiguration(
      behavior: RemoveGlow(),
      child: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Inserisci la tua email",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
                BeautyTextfield(
                  width: double.maxFinite,
                  height: 60,
                  duration: Duration(
                    milliseconds: 300,
                  ),
                  inputType: TextInputType.text,
                  backgroundColor: Colors.red,
                  textColor: Colors.red[200],
                  cornerRadius: BorderRadius.all(
                    Radius.circular(
                      26.0,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.account_circle,
                  ),
                  placeholder: "Email",
                  maxLines: 1,
                  onTap: () {},
                  onChanged: (t) {
                    Provider.of<AppState>(context).setEmail(t);
                    Provider.of<AppState>(context).setOffice(t);
                  },
                  onSubmitted: (d) {
                    Provider.of<AppState>(context).setEmail(d);
                    Provider.of<AppState>(context).setOffice(d);
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Inserisci la tua password",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                ),
                BeautyTextfield(
                  width: double.maxFinite,
                  height: 60,
                  duration: Duration(
                    milliseconds: 300,
                  ),
                  inputType: TextInputType.text,
                  backgroundColor: Colors.red,
                  textColor: Colors.red[200],
                  cornerRadius: BorderRadius.all(
                    Radius.circular(
                      26.0,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                  ),
                  placeholder: "Password",
                  obscureText: true,
                  maxLines: 1,
                  onTap: () {},
                  onChanged: (t) {},
                  onSubmitted: (d) {},
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 50,
                      width: 100,
                      child: ProgressButton(
                        onPressed: (AnimationController controller) async {
                          controller.forward();
                          await Future.delayed(Duration(milliseconds: 700), () {
                            widget.onTap();
                            controller.reset();
                          });
                        },
                        borderRadius: BorderRadius.all(
                          Radius.circular(26.0),
                        ),
                        strokeWidth: 3,
                        color: Colors.red,
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RemoveGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
