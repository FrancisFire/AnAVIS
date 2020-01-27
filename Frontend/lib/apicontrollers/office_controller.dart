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
  Map<String, String> _header;

  OfficeController(BuildContext context) {
    _ip = AppState().getIp();
    _header = AppState().getHttpHeaders();

    _baseUrl = "http://$_ip:8080/api/office";
  }

  Future<String> getOffices() async {
    http.Response res = await http.get(
      "$_baseUrl",
      //permit all
      headers: {
        "content-type": "application/json",
      },
    );
    return res.body;
  }

  Future<String> getDonationsTimeTable(String officeMail) async {
    http.Response res = await http.get(
      "$_baseUrl/$officeMail/timeTable",
      headers: this._header,
    );
    return res.body;
  }

  Future<String> addTimeSlot(String officeMail, TimeSlot timeSlot) async {
    http.Response res = await http.put(
      Uri.encodeFull("$_baseUrl/$officeMail/addTimeSlot"),
      body: json.encode({
        "dateTime": timeSlot.getDateTime(),
        "donorSlots": timeSlot.getSlots(),
      }),
      headers: this._header,
    );
    return res.body;
  }

  Future<String> getOfficeByMail(String officeMail) async {
    http.Response res = await http.get(
      "$_baseUrl/$officeMail",
      //permit all
      headers: {
        "content-type": "application/json",
      },
    );
    return res.body;
  }
}
