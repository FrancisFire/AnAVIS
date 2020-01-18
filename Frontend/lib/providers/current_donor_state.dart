/*import 'package:anavis/models/activeprenotation.dart';
import 'package:anavis/models/closedprenotation.dart';
import 'package:anavis/models/donationreport.dart';
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

  Future<DonationReport> getReportByDonationID(String donationId) async {
    var request = await http
        .get("http://${_ipReference}:8080/api/donation/report/${donationId}");
    var parsedJson = json.decode(request.body);
    var rep = parsedJson;
    return new DonationReport(
      rep['reportId'],
      rep['reportFile'],
      rep['donorMail'],
      rep['officeMail'],
      rep['date'],
    );
  }

  Future<void> removePrenotationByID(String id) async {
    http.Response res =
        await http.delete("http://${_ipReference}:8080/api/prenotation/$id");
    _statusBody = res.body == 'true';
    notifyListeners();
  }

  Future<void> removeRequestByID(String id) async {
    http.Response res =
        await http.put("http://${_ipReference}:8080/api/request/$id/deny");
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
        "officeMail": request.getOfficeMail(),
        "donorMail": request.getDonorMail(),
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

  bool getStatusBody() {
    return _statusBody;
  }

  Future<List<RequestPrenotation>> getDonorRequests(String donorMail) async {
    List<RequestPrenotation> requests = new List<RequestPrenotation>();
    String controllerRequest =
        await _requestController.getRequestsByDonor(donorMail);
    var parsedJson = json.decode(controllerRequest);
    for (var pren in parsedJson) {
      RequestPrenotation newRequest = RequestPrenotation(
        pren['id'],
        pren['officeMail'],
        pren['donorMail'],
        pren['hour'],
      );
      requests.add(newRequest);
    }
    return requests;
  }

  Future<List<ActivePrenotation>> getDonorActivePrenotations(
      String donorMail) async {
    List<ActivePrenotation> prenotations = new List<ActivePrenotation>();
    var request = await http
        .get("http://${_ipReference}:8080/api/prenotation/donor/${donorMail}");
    var parsedJson = json.decode(request.body);
    for (var pren in parsedJson) {
      ActivePrenotation newPrenotation = ActivePrenotation(
          pren['id'],
          pren['officeMail'],
          pren['donorMail'],
          pren['hour'],
          pren['confirmed']);
      if (newPrenotation.isConfirmed()) {
        prenotations.add(newPrenotation);
      }
    }
    return prenotations;
  }

  Future<List<ActivePrenotation>> getDonorPendingPrenotations(
      String donorMail) async {
    List<ActivePrenotation> prenotations = new List<ActivePrenotation>();
    var request = await http
        .get("http://${_ipReference}:8080/api/prenotation/donor/${donorMail}");
    var parsedJson = json.decode(request.body);
    for (var pren in parsedJson) {
      ActivePrenotation newPrenotation = ActivePrenotation(
          pren['id'],
          pren['officeMail'],
          pren['donorMail'],
          pren['hour'],
          pren['confirmed']);
      if (!newPrenotation.isConfirmed()) {
        prenotations.add(newPrenotation);
      }
    }
    return prenotations;
  }

  Future<List<ClosedPrenotation>> getDonorDonations(String donorMail) async {
    List<ClosedPrenotation> donations = new List<ClosedPrenotation>();
    var request = await http
        .get("http://${_ipReference}:8080/api/donation/donor/${donorMail}");
    var parsedJson = json.decode(request.body);
    for (var don in parsedJson) {
      ClosedPrenotation newDonation = ClosedPrenotation(
        don['id'],
        don['officeMail'],
        don['donorMail'],
        don['hour'],
        don['reportId'],
      );
      donations.add(newDonation);
    }
    return donations;
  }
}
*/
