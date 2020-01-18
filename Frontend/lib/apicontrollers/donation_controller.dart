import 'dart:async';

import 'package:anavis/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DonationController {
  String _ip;
  String _baseUrl;
  DonationController(BuildContext context) {
    _ip = AppState().getIp();
    _baseUrl = "http://$_ip:8080/api/donation";
  }

  Future<String> getDonationsByDonor(String donorMail) async {
    http.Response res = await http.get("$_baseUrl/donor/$donorMail");
    return res.body;
  }

  Future<String> getDonationReport(String donationId) async {
    http.Response res = await http.get("$_baseUrl/office/report/$donationId");
    return res.body;
  }
}
