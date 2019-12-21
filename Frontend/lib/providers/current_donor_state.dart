import 'package:anavis/models/activeprenotation.dart';
import 'package:anavis/models/prenotation.dart';
import 'package:anavis/models/requestprenotation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class CurrentDonorState extends ChangeNotifier {
  String _donorMail;
  bool _donorCanDonate;
  bool _statusBody;
  String _ipReference;

  CurrentDonorState(String ip) {
    this._ipReference = ip;
  }

  Future<void> setEmail(String email) async {
    _donorMail = email;
    this.setCanDonate();
  }

  void setCanDonate() async {
    var request = await http
        .get("http://${_ipReference}:8080/api/donor/$_donorMail/canDonate");
    _donorCanDonate = request.body == 'true';
    notifyListeners();
  }

  Future<List<ActivePrenotation>> getDonorActivePrenotations() async {
    List<ActivePrenotation> prenotations = new List<ActivePrenotation>();
    var request = await http
        .get("http://${_ipReference}:8080/api/prenotation/donor/${_donorMail}");
    var parsedJson = json.decode(request.body);
    for (var pren in parsedJson) {
      ActivePrenotation newPrenotation = ActivePrenotation(pren['id'],
          pren['officeId'], pren['donorId'], pren['hour'], pren['confirmed']);
      if (newPrenotation.isConfirmed()) {
        prenotations.add(newPrenotation);
      }
    }
    return prenotations;
  }

  Future<List<ActivePrenotation>> getDonorPendingPrenotations() async {
    List<ActivePrenotation> prenotations = new List<ActivePrenotation>();
    var request = await http
        .get("http://${_ipReference}:8080/api/prenotation/donor/${_donorMail}");
    var parsedJson = json.decode(request.body);
    for (var pren in parsedJson) {
      ActivePrenotation newPrenotation = ActivePrenotation(pren['id'],
          pren['officeId'], pren['donorId'], pren['hour'], pren['confirmed']);
      if (!newPrenotation.isConfirmed()) {
        prenotations.add(newPrenotation);
      }
    }
    return prenotations;
  }

  Future<void> removePrenotationByID(String id) async {
    http.Response res =
        await http.delete("http://${_ipReference}:8080/api/prenotation/$id");
    _statusBody = res.body == 'true';
    notifyListeners();
  }

  Future<void> acceptPrenotationChange(String id) async {
    http.Response res = await http
        .put("http://${_ipReference}:8080/api/prenotation/$id/acceptChange");
    _statusBody = res.body == 'true';
    notifyListeners();
  }

  Future<void> denyPrenotationChange(String id) async {
    http.Response res = await http
        .put("http://${_ipReference}:8080/api/prenotation/$id/denyChange");
    _statusBody = res.body == 'true';
    notifyListeners();
  }

  Future<dynamic> sendRequest(RequestPrenotation request) async {
    return await http.post(
      Uri.encodeFull("http://${_ipReference}:8080/api/request"),
      body: json.encode({
        "id": request.getId(),
        "officeId": request.getOfficeId(),
        "donorId": request.getDonorId(),
        "hour": request.getHour()
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

  String getDonorMail() {
    return _donorMail;
  }

  bool getStatusBody() {
    return _statusBody;
  }
}
