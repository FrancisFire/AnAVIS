import 'dart:core';

class AppState {
  String _ipReference;
  String _userMail;

  String getIp() {
    return _ipReference;
  }

  void setIpReference(String ip) {
    this._ipReference = ip;
  }

  void setUserMail(String mail) {
    this._userMail = mail;
  }

  String getUserMail() {
    return this._userMail;
  }

  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();
}
