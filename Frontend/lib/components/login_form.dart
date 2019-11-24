import 'package:flutter/material.dart';
import 'package:beauty_textfield/beauty_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatelessWidget {
  final Function onTap;

  LoginForm({this.onTap});

  @override
  Widget build(BuildContext context) {
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
                  onTap: () {
                    print('Click');
                  },
                  onChanged: (t) {
                    print(t);
                  },
                  onSubmitted: (d) {
                    print(d.length);
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
                  onTap: () {
                    print('Click');
                  },
                  onChanged: (t) {
                    print(t);
                  },
                  onSubmitted: (d) {
                    print(d.length);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 24.0,
                  ),
                  child: Center(
                    child: SizedBox(
                      height: 50,
                      child: RaisedButton.icon(
                        onPressed: () {
                          onTap();
                        },
                        elevation: 18.0,
                        icon: Icon(
                          FontAwesomeIcons.tint,
                          color: Colors.red,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(26.0),
                          ),
                        ),
                        color: Colors.white,
                        label: Text(
                          "Effettua il login",
                          style: TextStyle(
                            color: Colors.red,
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
