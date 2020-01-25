import 'package:anavis/models/authcredentials.dart';

class AdminUpdateRecapArgs {
  String _email;
  String _password;
  Role _role;
  AdminUpdateRecapArgs(String email, String password, Role role) {
    this._role = role;
    this._email = email;
    this._password = password;
  }

  Role getRole() {
    return _role;
  }

  String getEmail() {
    return _email;
  }

  String getPassword() {
    return _password;
  }
}
