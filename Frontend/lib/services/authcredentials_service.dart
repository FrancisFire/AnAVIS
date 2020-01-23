import 'dart:convert';

import 'package:anavis/apicontrollers/authcredentials_controller.dart';
import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/models/office.dart';
import 'package:flutter/cupertino.dart';

class AuthCredentialsService {
  AuthCredentialsController _authCredentialsController;

  Future<Role> getUserRole(String mail) async {
    String controllerJson = await _authCredentialsController.getUserRole(mail);
    var parsedJson = json.decode(controllerJson);
    switch (parsedJson) {
      case "DONOR":
        return Role.DONOR;
        break;
      case "OFFICE":
        return Role.OFFICE;
        break;
      case "ADMIN":
        return Role.OFFICE;
        break;
      default:
        return null;
    }
  }

  Future<Role> loginWithCredentials(AuthCredentials credentials) async {
    String controllerJson =
        await _authCredentialsController.loginWithCredentials(credentials);
    var parsedJson = json.decode(controllerJson);
    switch (parsedJson) {
      case "DONOR":
        return Role.DONOR;
        break;
      case "OFFICE":
        return Role.OFFICE;
        break;
      case "ADMIN":
        return Role.OFFICE;
        break;
      default:
        return null;
    }
  }

  Future<List<AuthCredentials>> getAuthCredentials() async {
    List<AuthCredentials> credentials = new List<AuthCredentials>();
    String controllerJson =
        await _authCredentialsController.getAuthCredentials();
    var parsedJson = json.decode(controllerJson);
    for (var credential in parsedJson) {
      Role role;
      switch (credential['role']) {
        case "DONOR":
          role = Role.DONOR;
          break;
        case "ADMIN":
          role = Role.ADMIN;
          break;
        case "OFFICE":
          role = Role.OFFICE;
          break;
      }
      AuthCredentials authC = new AuthCredentials(credential['mail']);
      authC.setRole(role);
      credentials.add(authC);
    }
    return credentials;
  }

  Future<bool> addDonorCredentials(
      Donor donor, AuthCredentials authCredentials) async {
    String controllerJson = await _authCredentialsController
        .addDonorCredentials(donor, authCredentials);
    return controllerJson == 'true';
  }

  Future<bool> updateCredentials(AuthCredentials authCredentials) async {
    String controllerJson =
        await _authCredentialsController.updateCredentials(authCredentials);
    return controllerJson == 'true';
  }

  Future<bool> addOfficeCredentials(
      Office office, AuthCredentials authCredentials) async {
    String controllerJson = await _authCredentialsController
        .addOfficeCredentials(office, authCredentials);
    return controllerJson == 'true';
  }

  void _setController(BuildContext context) {
    _authCredentialsController = new AuthCredentialsController(context);
  }

  static final AuthCredentialsService _singleton =
      AuthCredentialsService._internal();

  factory AuthCredentialsService(BuildContext context) {
    _singleton._setController(context);
    return _singleton;
  }

  AuthCredentialsService._internal();
}
