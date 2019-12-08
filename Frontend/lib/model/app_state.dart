import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart';

class AppState extends ChangeNotifier {
  String _donorMail;
  String _officeName;
  bool _donorCanDonate;
  String _officeNamesApi;
  String _donorsAvailableNamesApi;
  String _officeTimeTablesApi;
  String _officeRequestsApi;
  String _canDonateApi;
  String _requestDonor;
  bool _statusBody;
  List<String> _officeNames = new List<String>();
  Set<String> _availableDonorsByOffice = new Set<String>();
  Set<String> _officeTimeTables = new Set<String>();
  static const String ip = "10.0.12.194";
  AppState() {
    //setCanDonate();
    setOfficeNames();
  }

  void setEmail(String email) {
    _donorMail = email;
    this.setCanDonate();
    notifyListeners();
  }

  void setOffice(String office) {
    _officeName = office;
    notifyListeners();
  }

  void setCanDonate() async {
    _canDonateApi = "http://$ip:8080/api/donor/$_donorMail/canDonate";
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

  void setAvailableDonorsByOffice(String officeName) async {
    _donorsAvailableNamesApi =
        "http://$ip:8080/api/donor/office/$officeName/available";
    var request = await http.get(_donorsAvailableNamesApi);
    var parsedJson = json.decode(request.body);
    for (var office in parsedJson) {
      _availableDonorsByOffice.add(office['mail']);
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
    Response res = await http.put("http://$ip:8080/api/request/$id/approve");
    _statusBody = res.body == 'true';
    notifyListeners();
  }

  void denyRequestByID(String id) async {
    Response res = await http.put("http://$ip:8080/api/request/$id/deny");
    _statusBody = res.body == 'true';
    notifyListeners();
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
      notifyListeners();
    }).catchError((err) {
      _statusBody = false;
      notifyListeners();
    });
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

  Set<String> getDonorsByOffice() {
    return _availableDonorsByOffice;
  }

  Set<String> getOfficeTimeTables() {
    return _officeTimeTables;
  }

  String getDonorMail() {
    return _donorMail;
  }

  String getOfficeName() {
    return _officeName;
  }

  void showFlushbar(
      String title, String message, bool isGood, BuildContext context) {
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: 26,
      shouldIconPulse: true,
      title: title,
      icon: isGood
          ? Icon(
              Icons.check,
              size: 28.0,
              color: Colors.green[600],
            )
          : Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.red[600],
            ),
      message: message,
      duration: Duration(
        seconds: 6,
      ),
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    ).show(context);
  }
}
