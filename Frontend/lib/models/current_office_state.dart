import 'package:anavis/models/prenotation.dart';
import 'package:anavis/models/request.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class CurrentOfficeState extends ChangeNotifier {
  String _officeName;
  bool _statusBody;

  Set<String> _officeTimeTables = new Set<String>();
  String _ipReference;

  CurrentOfficeState(String ip) {
    _ipReference = ip;
  }
  void setOffice(String office) {
    _officeName = office;
  }

  Future<void> setOfficeTimeTables() async {
    var request = await http
        .get("http://${_ipReference}:8080/api/office/${_officeName}/timeTable");
    var parsedJson = json.decode(request.body);
    _officeTimeTables.clear();
    for (var time in parsedJson) {
      _officeTimeTables.add(time);
    }
    notifyListeners();
  }

  Future<List<Request>> getOfficeRequests() async {
    List<Request> requests = new List<Request>();
    var request = await http
        .get("http://${_ipReference}:8080/api/request/office/${_officeName}");
    var parsedJson = json.decode(request.body);
    for (var req in parsedJson) {
      Request newRequest =
          new Request(req['id'], req['officeId'], req['donorId'], req['hour']);
      requests.add(newRequest);
    }
    return requests;
  }

  Future<List<Prenotation>> getOfficePrenotations() async {
    List<Prenotation> prenotations = new List<Prenotation>();
    var request = await http.get(
        "http://${_ipReference}:8080/api/prenotation/office/${_officeName}");
    var parsedJson = json.decode(request.body);
    for (var pren in parsedJson) {
      Prenotation newPrenotation = Prenotation(pren['id'], pren['officeId'],
          pren['donorId'], pren['hour'], pren['confirmed']);
      prenotations.add(newPrenotation);
    }
    return prenotations;
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

  Future<void> removePrenotationByID(String id) async {
    http.Response res =
        await http.delete("http://${_ipReference}:8080/api/prenotation/$id");
    _statusBody = res.body == 'true';
    notifyListeners();
  }

  Future<dynamic> sendPrenotation(Prenotation prenotation) async {
    return await http.post(
      Uri.encodeFull("http://${_ipReference}:8080/api/prenotation"),
      body: json.encode({
        "id": prenotation.getId(),
        "officeId": prenotation.getOfficeId(),
        "donorId": prenotation.getDonorId(),
        "hour": prenotation.getHour(),
        "confirmed": prenotation.isConfirmed(),
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

  Future<dynamic> updatePrenotation(Prenotation prenotation) async {
    return await http.put(
      Uri.encodeFull("http://${_ipReference}:8080/api/prenotation"),
      body: json.encode({
        "id": prenotation.getId(),
        "officeId": prenotation.getOfficeId(),
        "donorId": prenotation.getDonorId(),
        "hour": prenotation.getHour(),
        "confirmed": prenotation.isConfirmed(),
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
