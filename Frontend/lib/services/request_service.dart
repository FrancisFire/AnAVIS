import 'dart:convert';

import 'package:anavis/apicontrollers/request_controller.dart';
import 'package:anavis/models/requestprenotation.dart';
import 'package:flutter/cupertino.dart';

class RequestService {
  RequestController _requestController;

  Future<bool> createRequest(RequestPrenotation request) async {
    String controllerJson = await _requestController.createRequest(request);
    return controllerJson == 'true';
  }

  Future<List<RequestPrenotation>> getRequestsByDonor(String donorMail) async {
    List<RequestPrenotation> requests = new List<RequestPrenotation>();
    String controllerJson =
        await _requestController.getRequestsByDonor(donorMail);
    var parsedJson = json.decode(controllerJson);
    for (var request in parsedJson) {
      requests.add(new RequestPrenotation(
        request['id'],
        request['officeMail'],
        request['donorMail'],
        request['hour'],
      ));
    }
    return requests;
  }

  Future<List<RequestPrenotation>> getRequestsByOffice(
      String officeMail) async {
    List<RequestPrenotation> requests = new List<RequestPrenotation>();
    String controllerJson =
        await _requestController.getRequestsByOffice(officeMail);
    var parsedJson = json.decode(controllerJson);
    for (var request in parsedJson) {
      requests.add(new RequestPrenotation(
        request['id'],
        request['officeMail'],
        request['donorMail'],
        request['hour'],
      ));
    }
    return requests;
  }

  Future<RequestPrenotation> getRequestById(String requestId) async {
    String controllerJson = await _requestController.getRequestById(requestId);
    var parsedJson = json.decode(controllerJson);
    var request = parsedJson[0];
    return new RequestPrenotation(
      request['id'],
      request['officeMail'],
      request['donorMail'],
      request['hour'],
    );
  }

  Future<bool> approveRequest(String requestId) async {
    String controllerJson = await _requestController.approveRequest(requestId);
    return controllerJson == 'true';
  }

  Future<bool> denyRequest(String requestId) async {
    String controllerJson = await _requestController.denyRequest(requestId);
    return controllerJson == 'true';
  }

  void _setController(BuildContext context) {
    _requestController = new RequestController(context);
  }

  static final RequestService _singleton = RequestService._internal();

  factory RequestService(BuildContext context) {
    _singleton._setController(context);
    return _singleton;
  }

  RequestService._internal();
}
