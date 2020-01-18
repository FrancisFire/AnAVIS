import 'dart:async';
import 'dart:convert';

import 'package:anavis/models/requestprenotation.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class RequestController {
  String _ip;
  String _baseUrl;
  RequestController(BuildContext context) {
    _ip = AppState().getIp();
    _baseUrl = "http://$_ip:8080/api/request";
  }

  Future<String> createRequest(RequestPrenotation request) async {
    http.Response res = await http.post(
      Uri.encodeFull("$_baseUrl"),
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
    );
    return res.body;

/*  return await http.post(
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
    }); */
  }

  Future<String> getRequestsByDonor(String donorMail) async {
    http.Response res = await http.get("$_baseUrl/donor/$donorMail");
    return res.body;
  }

  Future<String> getRequestsByOffice(String officeMail) async {
    http.Response res = await http.get("$_baseUrl/office/$officeMail");
    return res.body;
  }

  Future<String> getRequestById(String requestId) async {
    http.Response res = await http.get("$_baseUrl/$requestId");
    return res.body;
  }

  Future<String> approveRequest(String requestId) async {
    http.Response res = await http.put("$_baseUrl/$requestId/approve");
    return res.body;
  }

  Future<String> denyRequest(String requestId) async {
    http.Response res = await http.put("$_baseUrl/$requestId/deny");
    return res.body;
  }
}
