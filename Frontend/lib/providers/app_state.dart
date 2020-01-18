import 'package:anavis/models/donor.dart';
import 'package:anavis/models/office.dart';
import 'package:anavis/models/timeslot.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
