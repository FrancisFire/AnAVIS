import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/viewargs/admin_update_users_recap_args.dart';
import 'package:anavis/views/widgets/creation_field.dart';
import 'package:anavis/views/widgets/painter.dart';
import 'package:anavis/views/widgets/remove_glow.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AdminUpdateUserView extends StatefulWidget {
  final String oldMail;
  final Role role;
  AdminUpdateUserView({@required this.oldMail, @required this.role});
  @override
  _AdminUpdateUserViewState createState() => _AdminUpdateUserViewState();
}

class _AdminUpdateUserViewState extends State<AdminUpdateUserView> {
  String _password;

  Widget fab() {
    if (_password != null) {
      return FloatingActionButton(
        child: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
        backgroundColor: Colors.red[600],
        onPressed: () {
          Navigator.pushReplacementNamed(
            context,
            '/admin/updateuser/recap',
            arguments: new AdminUpdateRecapArgs(
              widget.oldMail,
              this._password,
              widget.role,
            ),
          );
        },
      );
    } else {
      return SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: fab(),
      body: CustomPaint(
        painter: Painter(
          first: Colors.red[400],
          second: Colors.red[900],
          background: Colors.red[600],
        ),
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Consts.padding),
                  topRight: Radius.circular(Consts.padding),
                  bottomLeft: Radius.zero,
                  bottomRight: Radius.zero,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                child: ScrollConfiguration(
                  behavior: RemoveGlow(),
                  child: ListView(
                    children: <Widget>[
                      Card(
                        elevation: 8,
                        color: Colors.deepOrange[600],
                        margin: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(
                              Icons.warning,
                              color: Colors.white,
                              size: 52,
                            ),
                            subtitle: Text(
                              "Una volta completati tutti i campi potrai cliccare sul pulsante in basso a destra per terminare la registrazione",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            dense: true,
                            title: Text(
                              "Attenzione!",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      CreationField(
                        icon: Icon(
                          Icons.lock,
                          color: Colors.red[600],
                        ),
                        chipTitle: "Inserisci la password",
                        hint: "Password",
                        onSaved: (newValue) {
                          setState(() {
                            this._password = newValue;
                          });
                        },
                        isPass: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: Consts.avatarRadius - 14),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      'Modifica le credenziali di accesso',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                      ),
                      maxLines: 1,
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: new BorderRadius.circular(62.0),
                          child: Container(
                            height: 4,
                            width: 80,
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 8),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: AutoSizeText(
                        "Si sta modificando la password di ${widget.oldMail}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}
