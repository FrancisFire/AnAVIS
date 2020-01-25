class GuestCreateDonorArgs {
  String _email;
  String _password;
  GuestCreateDonorArgs(String email, String password) {
    this._email = email;
    this._password = password;
  }

  String getEmail() {
    return _email;
  }

  String getPassword() {
    return _password;
  }
}
