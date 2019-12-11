import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class CurrentDonorState extends ChangeNotifier {
  String _donorMail;
  bool _donorCanDonate;
  String _canDonateApi;
  bool _statusBody;
  String _donorRequestApi;
  String _ipReference;

  CurrentDonorState(String ip) {
    this._ipReference = ip;
  }
  Future<void> setEmail(String email) async {
    _donorMail = email;
    this.setCanDonate();
    notifyListeners();
  }

  void setCanDonate() async {
    _canDonateApi =
        "http://${_ipReference}:8080/api/donor/$_donorMail/canDonate";
    var request = await http.get(_canDonateApi);
    _donorCanDonate = request.body == 'true';
    notifyListeners();
  }

  Future<List<dynamic>> getDonorPrenotationsJson() async {
    _donorRequestApi =
        "http://${_ipReference}:8080/api/prenotation/donor/${_donorMail}";
    var request = await http.get(_donorRequestApi);
    var parsedJson = json.decode(request.body);
    return parsedJson;
  }

  Future<dynamic> sendRequest(
    String id,
    String officePoint,
    String donor,
    String hour,
  ) async {
    _donorRequestApi = "http://${_ipReference}:8080/api/request";
    return await http.post(
      Uri.encodeFull(_donorRequestApi),
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

  String getDonorMail() {
    return _donorMail;
  }

  bool getStatusBody() {
    return _statusBody;
  }
}
