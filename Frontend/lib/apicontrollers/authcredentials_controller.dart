import 'dart:async';

import 'package:anavis/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AuthCredentialsController {
  String _ip;
  String _baseUrl;
  AuthCredentialsController(BuildContext context) {
    _ip = AppState().getIp();
    _baseUrl = "http://$_ip:8080/api/auth";
  }

  Future<String> getUserRoles(String mail) async {
    http.Response res = await http.get("$_baseUrl/roles/$mail");
    return res.body;
  }

  Future<String> getAuthCredentials() async {
    http.Response res = await http.get("$_baseUrl/");
    return res.body;
  }

  Future<String> addDonorCredentials(String donorMail) async {
    //TODO
  }

  Future<String> addOfficeCredentials(String donationId) async {
    //TODO
  }

  Future<String> updateCredentials(String donorMail) async {
    //TODO
  }

  Future<String> removeCredentials(String mail) async {
    http.Response res = await http.delete("$_baseUrl/$mail");
    return res.body;
  }
}
