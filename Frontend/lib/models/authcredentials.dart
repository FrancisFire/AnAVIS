class AuthCredentials {
  String _mail;
  String _password;
  Set<Role> _roles;
  AuthCredentials(String mail, Set<Role> roles) {
    this._mail = mail;
    this._roles = roles;
    this._password = "";
  }
  AuthCredentials.complete(String mail, String password, Set<Role> roles) {
    AuthCredentials(mail, roles);
    this._password = password;
  }

  String getMail() {
    return _mail;
  }

  String getPassword() {
    return _password;
  }

  Set<Role> getRoles() {
    return _roles;
  }
}

enum Role {
  DONOR,
  OFFICE,
  ADMIN,
}
