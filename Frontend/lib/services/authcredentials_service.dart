import 'dart:convert';

import 'package:anavis/apicontrollers/authcredentials_controller.dart';
import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/models/donor.dart';
import 'package:anavis/models/office.dart';
import 'package:flutter/cupertino.dart';

class AuthCredentialsService {
  AuthCredentialsController _authCredentialsController;

  Future<List<Role>> getUserRoles(String mail) async {
    List<Role> roles = new List<Role>();
    String controllerJson = await _authCredentialsController.getUserRoles(mail);
    var parsedJson = json.decode(controllerJson);
    for (var role in parsedJson) {
      switch (role) {
        case "DONOR":
          roles.add(Role.DONOR);
          break;
        case "OFFICE":
          roles.add(Role.OFFICE);
          break;
        case "ADMIN":
          roles.add(Role.OFFICE);
          break;
      }
    }
    return roles;
  }

  Future<List<AuthCredentials>> getAuthCredentials() async {
    List<AuthCredentials> credentials = new List<AuthCredentials>();
    String controllerJson =
        await _authCredentialsController.getAuthCredentials();
    var parsedJson = json.decode(controllerJson);
    for (var credential in parsedJson) {
      Set<Role> roles = new Set<Role>();
      for (var r in credential['roles']) {
        switch (r) {
          case "DONOR":
            roles.add(Role.DONOR);
            break;
          case "ADMIN":
            roles.add(Role.ADMIN);
            break;
          case "OFFICE":
            roles.add(Role.OFFICE);
            break;
        }
      }
      credentials.add(new AuthCredentials(credential['mail'], roles));
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
