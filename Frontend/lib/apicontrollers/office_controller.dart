import 'dart:async';
import 'dart:convert';

import 'package:anavis/models/timeslot.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class OfficeController {
  String _ip;
  String _baseUrl;
  OfficeController(BuildContext context) {
    _ip = AppState().getIp();
    _baseUrl = "http://$_ip:8080/api/office";
  }

  Future<String> getOffices() async {
    http.Response res = await http.get("$_baseUrl");
    return res.body;
  }

  Future<String> getDonationsTimeTable(String officeMail) async {
    http.Response res = await http.get("$_baseUrl/$officeMail/timeTable");
    return res.body;
  }

  Future<String> addTimeSlot(String officeMail, TimeSlot timeSlot) async {
    http.Response res = await http.put(
      Uri.encodeFull("$_baseUrl/$officeMail/addTimeSlot"),
      body: json.encode({
        "dateTime": timeSlot.getDateTime(),
        "donorSlots": timeSlot.getSlots(),
      }),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
      },
    );
    return res.body;

    /*return await http.put(
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
    });*/
  }

  Future<String> getOfficeByMail(String officeMail) async {
    http.Response res = await http.get("$_baseUrl/$officeMail");
    return res.body;
  }
}