import 'dart:async';
import 'dart:convert';

import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/models/office.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthCredentialsController {
  String _ip;
  String _baseUrl;
  Map<String, String> _header;
  AuthCredentialsController(BuildContext context) {
    _ip = AppState().getIp();
    _header = AppState().getHttpHeaders();
    _baseUrl = "http://$_ip:8080/api/auth";
  }

  Future<String> getUserRole(String mail) async {
    http.Response res = await http.get(
      "$_baseUrl/roles/$mail",
      headers: this._header,
    );
    return res.body;
  }

  Future<String> loginWithCredentials(AuthCredentials credentials) async {
    http.Response res = await http.post(Uri.encodeFull("$_baseUrl/login"),
        body: json.encode({
          "mail": credentials.getMail(),
          "password": credentials.getPassword(),
        }),
        //permit all
        headers: {
          "content-type": "application/json",
        });
    return res.body;
  }

  Future<String> getAuthCredentials() async {
    http.Response res = await http.get(
      "$_baseUrl/",
      headers: this._header,
    );
    return res.body;
  }

  Future<String> addDonorCredentials(
      Donor donor, AuthCredentials authCredentials) async {
    http.Response res = await http.post(
      Uri.encodeFull("$_baseUrl/donor"),
      body: json.encode({
        "donor": {
          "mail": donor.getMail(),
          "officeMail": donor.getOfficeMail(),
          "canDonate": donor.canDonate(),
          "lastDonation": donor.getLastDonation(),
          "category": donor.getCategory(),
          "name": donor.getName(),
          "surname": donor.getSurname(),
          "birthday": donor.getBirthday(),
          "birthPlace": donor.getBirthPlace(),
          "leftDonationsInYear": donor.getLeftDonationsInYear(),
          "firstDonationInYear": donor.getFirstDonationInYear(),
        },
        "authCredentials": {
          "mail": authCredentials.getMail(),
          "password": authCredentials.getPassword(),
          "role": _getRoleName(authCredentials.getRole()),
        }
      }),
      //permit all
      headers: {
        "content-type": "application/json",
      },
    );
    return res.body;
  }

  Future<String> addOfficeCredentials(
      Office office, AuthCredentials authCredentials) async {
    http.Response res = await http.post(
      Uri.encodeFull("$_baseUrl/office"),
      body: json.encode({
        "office": {
          "mail": office.getMail(),
          "place": office.getPlace(),
          "donationTimeTable": [],
        },
        "authCredentials": {
          "mail": authCredentials.getMail(),
          "password": authCredentials.getPassword(),
          "role": _getRoleName(authCredentials.getRole()),
        }
      }),
      headers: this._header,
    );
    return res.body;
  }

  Future<String> updateCredentials(AuthCredentials authCredentials) async {
    http.Response res = await http.put(
      Uri.encodeFull("$_baseUrl/"),
      body: json.encode({
        "mail": authCredentials.getMail(),
        "password": authCredentials.getPassword(),
        "role": _getRoleName(authCredentials.getRole()),
      }),
      headers: this._header,
    );
    return res.body;
  }

  Future<String> removeCredentials(String mail) async {
    http.Response res = await http.delete(
      "$_baseUrl/$mail",
      headers: this._header,
    );
    return res.body;
  }

  String _getRoleName(Role role) {
    switch (role) {
      case Role.DONOR:
        return "DONOR";
      case Role.ADMIN:
        return "ADMIN";
      case Role.OFFICE:
        return "OFFICE";
    }
  }
}
