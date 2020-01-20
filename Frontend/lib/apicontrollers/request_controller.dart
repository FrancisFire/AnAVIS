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
  Map<String, String> _header;

  RequestController(BuildContext context) {
    _ip = AppState().getIp();
    _header = AppState().getHttpHeaders();

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
      headers: this._header,
    );
    return res.body;
  }

  Future<String> getRequestsByDonor(String donorMail) async {
    http.Response res = await http.get(
      "$_baseUrl/donor/$donorMail",
      headers: this._header,
    );
    return res.body;
  }

  Future<String> getRequestsByOffice(String officeMail) async {
    http.Response res = await http.get(
      "$_baseUrl/office/$officeMail",
      headers: this._header,
    );
    return res.body;
  }

  Future<String> getRequestById(String requestId) async {
    http.Response res = await http.get(
      "$_baseUrl/$requestId",
      headers: this._header,
    );
    return res.body;
  }

  Future<String> approveRequest(String requestId) async {
    http.Response res = await http.put(
      "$_baseUrl/$requestId/approve",
      headers: this._header,
    );
    return res.body;
  }

  Future<String> denyRequest(String requestId) async {
    http.Response res = await http.put(
      "$_baseUrl/$requestId/deny",
      headers: this._header,
    );
    return res.body;
  }
}
