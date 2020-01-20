/*import 'dart:io';

import 'package:anavis/models/activeprenotation.dart';
import 'package:anavis/models/requestprenotation.dart';
import 'package:anavis/models/timeslot.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class CurrentOfficeState extends ChangeNotifier {
  String _officeMail;
  bool _statusBody;

  Set<TimeSlot> _officeTimeTables = new Set<TimeSlot>();
  Set<TimeSlot> _officeTimeTablesByOffice = new Set<TimeSlot>();
  String _ipReference;

  CurrentOfficeState(String ip) {
    _ipReference = ip;
  }

  void setOfficeMail(String officeMail) {
    _officeMail = officeMail;
  }

  Future<void> setOfficeTimeTables() async {
    var request = await http
        .get("http://${_ipReference}:8080/api/office/${_officeMail}/timeTable");
    var parsedJson = json.decode(request.body);
    _officeTimeTables.clear();
    for (var time in parsedJson) {
      _officeTimeTables.add(TimeSlot(time['dateTime'], time['donorSlots']));
    }
    notifyListeners();
  }

  Future<void> setOfficeTimeTablesByOffice(String office) async {
    var request = await http
        .get("http://$_ipReference:8080/api/office/$office/timeTable");
    var parsedJson = json.decode(request.body);
    _officeTimeTablesByOffice.clear();
    for (var time in parsedJson) {
      _officeTimeTablesByOffice
          .add(TimeSlot(time['dateTime'], time['donorSlots']));
    }
    notifyListeners();
  }

  Future<List<RequestPrenotation>> getOfficeRequests() async {
    List<RequestPrenotation> requests = new List<RequestPrenotation>();
    var request = await http
        .get("http://${_ipReference}:8080/api/request/office/${_officeMail}");
    var parsedJson = json.decode(request.body);
    for (var req in parsedJson) {
      RequestPrenotation newRequest = new RequestPrenotation(
        req['id'],
        req['officeMail'],
        req['donorMail'],
        req['hour'],
      );
      requests.add(newRequest);
    }
    return requests;
  }

  Future<List<ActivePrenotation>> getOfficePrenotations() async {
    List<ActivePrenotation> prenotations = new List<ActivePrenotation>();
    var request = await http.get(
        "http://${_ipReference}:8080/api/prenotation/office/${_officeMail}");
    var parsedJson = json.decode(request.body);
    for (var pren in parsedJson) {
      ActivePrenotation newPrenotation = ActivePrenotation(
          pren['id'],
          pren['officeMail'],
          pren['donorMail'],
          pren['hour'],
          pren['confirmed']);
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

  Future<void> closePrenotation(String id, File file) async {
    if (file == null) {
      _statusBody = false;
      notifyListeners();
      return;
    }
    FormData formData = new FormData();

    formData.files
        .add(MapEntry("file", await MultipartFile.fromFile(file.path)));

    return await Dio()
        .put("http://${_ipReference}:8080/api/prenotation/$id/close",
            data: formData)
        .then((res) {
      _statusBody = res.data.toString() == 'true';
      notifyListeners();
    }).catchError((err) {
      _statusBody = false;
      notifyListeners();
    });
  }

  Future<dynamic> sendPrenotation(ActivePrenotation prenotation) async {
    return await http.post(
      Uri.encodeFull("http://${_ipReference}:8080/api/prenotation"),
      body: json.encode({
        "id": prenotation.getId(),
        "officeMail": prenotation.getOfficeMail(),
        "donorMail": prenotation.getDonorMail(),
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

  Future<dynamic> updatePrenotation(ActivePrenotation prenotation) async {
    return await http.put(
      Uri.encodeFull("http://${_ipReference}:8080/api/prenotation"),
      body: json.encode({
        "id": prenotation.getId(),
        "officeMail": prenotation.getOfficeMail(),
        "donorMail": prenotation.getDonorMail(),
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

  Future<dynamic> addTimeTableSlot(TimeSlot timeslot) async {
    return await http.put(
      Uri.encodeFull(
          "http://${_ipReference}:8080/api/office/$_officeMail/addTimeSlot"),
      body: json.encode({
        "dateTime": timeslot.getDateTime(),
        "donorSlots": timeslot.getSlots(),
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

  Set<TimeSlot> getOfficeTimeTables() {
    return _officeTimeTables;
  }

  Set<TimeSlot> getOfficeAvailableTimeTablesByOffice() {
    Set<TimeSlot> available = new Set<TimeSlot>();
    for (TimeSlot slot in _officeTimeTablesByOffice) {
      if (slot.getSlots() > 0) {
        available.add(slot);
      }
    }
    return available;
  }

  Set<TimeSlot> getAvailableTimeTables() {
    Set<TimeSlot> available = new Set<TimeSlot>();
    for (TimeSlot slot in _officeTimeTables) {
      if (slot.getSlots() > 0) {
        available.add(slot);
      }
    }
    return available;
  }

  String getOfficeMail() {
    return _officeMail;
  }
}
*/
