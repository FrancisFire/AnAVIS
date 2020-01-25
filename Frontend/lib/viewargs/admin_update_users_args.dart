import 'package:anavis/models/authcredentials.dart';

class AdminUpdateArgs {
  String _oldMail;
  Role _role;
  AdminUpdateArgs(String email, Role role) {
    this._role = role;
    this._oldMail = email;
  }

  Role getRole() {
    return _role;
  }

  String getEmail() {
    return _oldMail;
  }
}
