import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart';

class AppState extends ChangeNotifier {
  String _donorMail;
  bool _donorCanDonate;
  String _canDonateApi;
  String _officeNamesApi;
  String _officeTimeTablesApi;
  String _officeRequestsApi;
  String _requestDonor;
  bool _statusBody;
  List<String> _officeNames = new List<String>();
  Set<String> _officeTimeTables = new Set<String>();
  static const String ip = "46.101.201.248";

  AppState() {
    _donorMail = 'stelluti@mail.com';
    _canDonateApi = "http://$ip:8080/api/donor/$_donorMail/canDonate";
    setCanDonate();
    setOfficeNames();
  }

  void setCanDonate() async {
    var request = await http.get(_canDonateApi);
    _donorCanDonate = request.body == 'true';
    notifyListeners();
  }

  void setOfficeNames() async {
    _officeNamesApi = "http://$ip:8080/api/office";
    var request = await http.get(_officeNamesApi);
    var parsedJson = json.decode(request.body);
    for (var office in parsedJson) {
      _officeNames.add(office['name']);
    }
    notifyListeners();
  }

  void setOfficeTimeTables(String officeName) async {
    _officeTimeTablesApi = "http://$ip:8080/api/office/$officeName/timeTable";
    var request = await http.get(_officeTimeTablesApi);
    var parsedJson = json.decode(request.body);
    _officeTimeTables.clear();
    for (var time in parsedJson) {
      _officeTimeTables.add(time);
    }
    notifyListeners();
  }

  Future<List<dynamic>> getOfficeRequestsJson(String officeName) async {
    _officeRequestsApi = "http://$ip:8080/api/request/office/$officeName";
    var request = await http.get(_officeRequestsApi);
    var parsedJson = json.decode(request.body);
    return parsedJson;
  }

  void approveRequestByID(String id) async {
    await http.put("http://$ip:8080/api/request/$id/approve");
  }

  void denyRequestByID(String id) async {
    await http.put("http://$ip:8080/api/request/$id/deny");
  }

  Future<dynamic> sendRequest(
    String id,
    String officePoint,
    String donor,
    String hour,
  ) async {
    _requestDonor = "http://$ip:8080/api/request";
    return await http.post(
      Uri.encodeFull(_requestDonor),
      body: json.encode({
        "id": id,
        "officePoint": {
          "name": officePoint,
        },
        "donor": {
          "mail": donor,
        },
        "hour": hour
      }),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    ).then((res) {
      _statusBody = res.body == 'true';
    }).catchError((err) {
      _statusBody = false;
    });
    notifyListeners();
  }

  bool getCanDonate() {
    return _donorCanDonate;
  }

  bool getStatusBody() {
    return _statusBody;
  }

  List<String> getOfficeNames() {
    return _officeNames;
  }

  Set<String> getOfficeTimeTables() {
    return _officeTimeTables;
  }

  String getDonorMail() {
    return _donorMail;
  }
}
