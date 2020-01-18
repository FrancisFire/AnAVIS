import 'dart:convert';
import 'dart:io';

import 'package:anavis/apicontrollers/prenotation_controller.dart';
import 'package:anavis/models/activeprenotation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class PrenotationService {
  PrenotationController _prenotationController;
  PrenotationService(BuildContext context) {
    _prenotationController = new PrenotationController(context);
  }

  Future<bool> createPrenotation(ActivePrenotation prenotation) async {
    String controllerJson =
        await _prenotationController.createPrenotation(prenotation);
    return controllerJson == 'true';
  }

  Future<List<ActivePrenotation>> getPrenotationsByOffice(
      String officeMail) async {
    List<ActivePrenotation> prenotations = new List<ActivePrenotation>();
    String controllerJson =
        await _prenotationController.getPrenotationsByOffice(officeMail);
    var parsedJson = json.decode(controllerJson);
    for (var prenotation in parsedJson) {
      prenotations.add(new ActivePrenotation(
        prenotation['id'],
        prenotation['officeMail'],
        prenotation['donorMail'],
        prenotation['hour'],
        prenotation['confirmed'],
      ));
    }
    return prenotations;
  }

  Future<List<ActivePrenotation>> getPrenotationsByDonor(
      String donorMail) async {
    List<ActivePrenotation> prenotations = new List<ActivePrenotation>();
    String controllerJson =
        await _prenotationController.getPrenotationsByDonor(donorMail);
    var parsedJson = json.decode(controllerJson);
    for (var prenotation in parsedJson) {
      prenotations.add(new ActivePrenotation(
        prenotation['id'],
        prenotation['officeMail'],
        prenotation['donorMail'],
        prenotation['hour'],
        prenotation['confirmed'],
      ));
    }
    return prenotations;
  }

  Future<bool> updatePrenotation(ActivePrenotation prenotation) async {
    String controllerJson =
        await _prenotationController.updatePrenotation(prenotation);
    return controllerJson == 'true';
  }

  Future<bool> removePrenotation(String prenotationId) async {
    String controllerJson =
        await _prenotationController.removePrenotation(prenotationId);
    return controllerJson == 'true';
  }

  Future<bool> acceptPrenotationChange(String prenotationId) async {
    String controllerJson =
        await _prenotationController.acceptPrenotationChange(prenotationId);
    return controllerJson == 'true';
  }

  Future<bool> denyPrenotationChange(String prenotationId) async {
    String controllerJson =
        await _prenotationController.denyPrenotationChange(prenotationId);
    return controllerJson == 'true';
  }

  Future<bool> closePrenotation(String prenotationId, File file) async {
    if (file == null) {
      return false;
    }
    FormData formData = new FormData();
    formData.files
        .add(MapEntry("file", await MultipartFile.fromFile(file.path)));
    String controllerJson =
        await _prenotationController.closePrenotation(prenotationId, formData);
    return controllerJson == 'true';
  }

  Future<List<ActivePrenotation>> getDonorNotConfirmedPrenotations(
      String donorMail) async {
    List<ActivePrenotation> notConfirmed = new List<ActivePrenotation>();
    List<ActivePrenotation> allPrenotations =
        await this.getPrenotationsByDonor(donorMail);
    for (var pren in allPrenotations) {
      if (!pren.isConfirmed()) {
        notConfirmed.add(pren);
      }
    }
    return notConfirmed;
  }
}
