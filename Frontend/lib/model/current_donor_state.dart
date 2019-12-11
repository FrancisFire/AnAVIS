import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class CurrentDonorState extends ChangeNotifier {
  String _donorMail;
  bool _donorCanDonate;
  String _canDonateApi;
  bool _statusBody;
  String _requestDonor;
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

  Future<dynamic> sendRequest(
    String id,
    String officePoint,
    String donor,
    String hour,
  ) async {
    _requestDonor = "http://${_ipReference}:8080/api/request";
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

  String getDonorMail() {
    return _donorMail;
  }

  bool getStatusBody() {
    return _statusBody;
  }
}
