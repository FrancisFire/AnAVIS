class AdminCreateRecapArgs {
  String _city;
  String _email;
  String _password;
  AdminCreateRecapArgs(String city, String email, String password) {
    this._city = city;
    this._email = email;
    this._password = password;
  }

  String getCity() {
    return _city;
  }

  String getEmail() {
    return _email;
  }

  String getPassword() {
    return _password;
  }
}
