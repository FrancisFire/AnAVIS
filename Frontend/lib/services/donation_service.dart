import 'dart:convert';

import 'package:anavis/apicontrollers/donation_controller.dart';
import 'package:anavis/models/closedprenotation.dart';
import 'package:anavis/models/donationreport.dart';
import 'package:flutter/cupertino.dart';

class DonationService {
  DonationController _donationController;

  Future<List<ClosedPrenotation>> getDonationsByDonor(String donorMail) async {
    List<ClosedPrenotation> donations = new List<ClosedPrenotation>();
    String controllerJson =
        await _donationController.getDonationsByDonor(donorMail);
    var parsedJson = json.decode(controllerJson);
    for (var donation in parsedJson) {
      donations.add(new ClosedPrenotation(
        donation['id'],
        donation['officeMail'],
        donation['donorMail'],
        donation['hour'],
        donation['reportId'],
      ));
    }
    return donations;
  }

  Future<DonationReport> getDonationReport(String donationId) async {
    String controllerJson =
        await _donationController.getDonationReport(donationId);
    var parsedJson = json.decode(controllerJson);
    var rep = parsedJson[0];
    return new DonationReport(
      rep['reportId'],
      rep['reportFile'],
      rep['donorMail'],
      rep['officeMail'],
      rep['date'],
    );
  }

  void _setController(BuildContext context) {
    _donationController = new DonationController(context);
  }

  static final DonationService _singleton = DonationService._internal();

  factory DonationService(BuildContext context) {
    _singleton._setController(context);
    return _singleton;
  }

  DonationService._internal();
}
