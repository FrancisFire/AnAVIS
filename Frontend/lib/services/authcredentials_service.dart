import 'dart:convert';

import 'package:anavis/apicontrollers/authcredentials_controller.dart';
import 'package:anavis/models/authcredentials.dart';
import 'package:flutter/cupertino.dart';

class AuthCredentialsService {
  AuthCredentialsController _authCredentialsController;
  AuthCredentialsService(BuildContext context) {
    _authCredentialsController = new AuthCredentialsController(context);
  }

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

  //TODO ALTRI METODI PER LE CREDENZIALI
}