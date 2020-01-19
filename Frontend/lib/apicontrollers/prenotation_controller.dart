import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:anavis/models/activeprenotation.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PrenotationController {
  String _ip;
  String _baseUrl;
  PrenotationController(BuildContext context) {
    _ip = AppState().getIp();
    _baseUrl = "http://$_ip:8080/api/prenotation";
  }

  Future<String> createPrenotation(ActivePrenotation prenotation) async {
    http.Response res = await http.post(
      Uri.encodeFull("$_baseUrl"),
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
    );
    return res.body;

    /*return await http.post(
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
    });*/
  }

  Future<String> getPrenotationsByOffice(String officeMail) async {
    http.Response res = await http.get("$_baseUrl/office/$officeMail");
    return res.body;
  }

  Future<String> getPrenotationsByDonor(String donorMail) async {
    http.Response res = await http.get("$_baseUrl/donor/$donorMail");
    return res.body;
  }

  Future<String> updatePrenotation(ActivePrenotation prenotation) async {
    http.Response res = await http.put(
      Uri.encodeFull("$_baseUrl"),
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
    );
    return res.body;

    /*return await http.put(
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
    });*/
  }

  Future<String> removePrenotation(String prenotationId) async {
    http.Response res = await http.delete("$_baseUrl/$prenotationId");
    return res.body;
  }

  Future<String> acceptPrenotationChange(String prenotationId) async {
    http.Response res = await http.put("$_baseUrl/$prenotationId/acceptChange");
    return res.body;
  }

  Future<String> denyPrenotationChange(String prenotationId) async {
    http.Response res = await http.put("$_baseUrl/$prenotationId/denyChange");
    return res.body;
  }

  Future<String> closePrenotation(
      String prenotationId, dio.FormData formData) async {
    dio.Response<dynamic> res =
        await dio.Dio().put("$_baseUrl/$prenotationId/close", data: formData);
    return res.data.toString();
  }
}
