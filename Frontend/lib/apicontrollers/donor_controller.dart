import 'dart:async';

import 'package:anavis/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DonorController {
  String _ip;
  String _baseUrl;
  Map<String, String> _header;

  DonorController(BuildContext context) {
    _ip = AppState().getIp();
    _header = AppState().getHttpHeaders();

    _baseUrl = "http://$_ip:8080/api/donor";
  }

  Future<String> checkDonationPossibility(String donorMail) async {
    http.Response res = await http.get(
      "$_baseUrl/$donorMail/canDonate",
      headers: this._header,
    );
    return res.body;
  }

  Future<String> getAvailableDonorsByOfficeId(String officeMail) async {
    http.Response res = await http.get(
      "$_baseUrl/office/$officeMail/available",
      headers: this._header,
    );
    return res.body;
  }

  Future<String> getDonorByMail(String donorMail) async {
    http.Response res = await http.get(
      "$_baseUrl/$donorMail",
      headers: this._header,
    );
    return res.body;
  }
}
