import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class CurrentOfficeState extends ChangeNotifier {
  String _officeName;
  String _officeTimeTablesApi;
  String _officeRequestsApi;
  String _newPrenotationApi;
  bool _statusBody;

  Set<String> _officeTimeTables = new Set<String>();
  String _ipReference;

  CurrentOfficeState(String ip) {
    _ipReference = ip;
  }
  void setOffice(String office) {
    _officeName = office;
    notifyListeners();
  }

  Future<void> setOfficeTimeTables() async {
    _officeTimeTablesApi =
        "http://${_ipReference}:8080/api/office/${_officeName}/timeTable";
    var request = await http.get(_officeTimeTablesApi);
    var parsedJson = json.decode(request.body);
    _officeTimeTables.clear();
    for (var time in parsedJson) {
      _officeTimeTables.add(time);
    }
    notifyListeners();
  }

  Future<List<dynamic>> getOfficeRequestsJson() async {
    _officeRequestsApi =
        "http://${_ipReference}:8080/api/request/office/${_officeName}";
    var request = await http.get(_officeRequestsApi);
    var parsedJson = json.decode(request.body);
    return parsedJson;
  }

  Future<List<dynamic>> getOfficePrenotationsJson(String officeName) async {
    _officeRequestsApi =
        "http://${_ipReference}:8080/api/prenotation/office/${_officeName}";
    var request = await http.get(_officeRequestsApi);
    var parsedJson = json.decode(request.body);
    return parsedJson;
  }

  Future<void> approveRequestByID(String id) async {
    http.Response res =
        await http.put("http://${_ipReference}:8080/api/request/$id/approve");
    _statusBody = res.body == 'true';
    notifyListeners();
  }

  Future<void> denyRequestByID(String id) async {
    http.Response res =
        await http.put("http://${_ipReference}:8080/api/request/$id/deny");
    _statusBody = res.body == 'true';
    notifyListeners();
  }

  Future<dynamic> sendPrenotation(
    String id,
    String officePoint,
    String donor,
    String hour,
  ) async {
    _newPrenotationApi = "http://${_ipReference}:8080/api/prenotation";
    return await http.post(
      Uri.encodeFull(_newPrenotationApi),
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
      notifyListeners();
    }).catchError((err) {
      _statusBody = false;
      notifyListeners();
    });
  }

  bool getStatusBody() {
    return _statusBody;
  }

  Set<String> getOfficeTimeTables() {
    return _officeTimeTables;
  }

  String getOfficeName() {
    return _officeName;
  }
}
