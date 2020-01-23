class AuthCredentials {
  String _mail;
  String _password;
  Role _role;
  AuthCredentials(String mail) {
    this._mail = mail;
  }
  AuthCredentials.complete(String mail, String password, Role role) {
    this._mail = mail;
    this._role = role;
    this._password = password;
  }

  String getMail() {
    return _mail;
  }

  String getPassword() {
    return _password;
  }

  void setPassword(String pass) {
    this._password = pass;
  }

  void setRole(Role role) {
    this._role = role;
  }

  Role getRole() {
    return _role;
  }
}

enum Role {
  DONOR,
  OFFICE,
  ADMIN,
}
