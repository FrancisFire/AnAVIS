import 'dart:convert';
import 'dart:core';

import 'package:anavis/models/authcredentials.dart';

class AppState {
  String _ipReference;
  String _userMail;
  String _pass;
  Role _role;

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

  void setPass(String pass) {
    this._pass = pass;
  }

  String getPass() {
    return this._pass;
  }

  Role getRole() {
    return this._role;
  }

  void setRole(Role role) {
    this._role = role;
  }

  Map<String, String> getHttpHeaders() {
    var bytes = utf8.encode("$_userMail:$_pass");
    var credentials = base64.encode(bytes);
    var headers = {
      "content-type": "application/json",
      "accept": "application/json",
      "authorization": "Basic $credentials"
    };
    return headers;
  }

  void logout() {
    this._userMail = null;
    this._pass = null;
    this._role = null;
  }

  static final AppState _singleton = AppState._internal();

  factory AppState() {
    return _singleton;
  }

  AppState._internal();
}
