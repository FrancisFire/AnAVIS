import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class AppState extends ChangeNotifier {
  AppState() {
    _donorMail = 'stelluti@mail.com';
    _canDonateApi = "http://10.0.4.250:8080/api/donor/$_donorMail/canDonate";
    _officeNamesApi = "http://10.0.4.250:8080/api/office";
    setCanDonate();
    setOfficeNames();
  }
  String _donorMail;
  bool _donorCanDonate;
  String _canDonateApi;
  String _officeNamesApi;
  List<String> _officeNames = new List<String>();

  void setCanDonate() async {
    var request = await http.get(_canDonateApi);
    _donorCanDonate = request.body == 'true';
    notifyListeners();
  }

  void setOfficeNames() async {
    var request = await http.get(_officeNamesApi);
    var parsedJson = json.decode(request.body);
    for (var office in parsedJson) {
      _officeNames.add(office['name']);
    }
    notifyListeners();
  }

  bool getCanDonate() {
    return _donorCanDonate;
  }

  List<String> getOfficeNames() {
    return _officeNames;
  }

  String getDonorMail() {
    return _donorMail;
  }
}
