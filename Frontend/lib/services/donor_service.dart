import 'dart:convert';

import 'package:anavis/apicontrollers/donor_controller.dart';
import 'package:anavis/models/donor.dart';
import 'package:flutter/cupertino.dart';

class DonorService {
  DonorController _donorController;
  DonorService(BuildContext context) {
    _donorController = new DonorController(context);
  }
  Future<bool> checkDonationPossibility(String donorMail) async {
    String canDonate =
        await _donorController.checkDonationPossibility(donorMail);
    return canDonate == 'true';
  }

  Future<List<Donor>> getAvailableDonorsByOfficeId(String officeMail) async {
    List<Donor> donors = new List<Donor>();
    String controllerJson =
        await _donorController.getAvailableDonorsByOfficeId(officeMail);
    var parsedJson = json.decode(controllerJson);
    for (var donor in parsedJson) {
      donors.add(new Donor.complete(
          donor['mail'],
          donor['officeMail'],
          donor['category'],
          donor['name'],
          donor['surname'],
          donor['birthday'],
          donor['birthPlace'],
          donor['canDonate'],
          donor['lastDonation'],
          donor['leftDonationsInYear'],
          donor['firstDonationInYear']));
    }
    return donors;
  }

  Future<Donor> getDonorByMail(String donorMail) async {
    String controllerJson = await _donorController.getDonorByMail(donorMail);
    var parsedJson = json.decode(controllerJson);
    var donorJson = parsedJson[0];
    Donor donor = new Donor.complete(
        donorJson['mail'],
        donorJson['officeMail'],
        donorJson['category'],
        donorJson['name'],
        donorJson['surname'],
        donorJson['birthday'],
        donorJson['birthPlace'],
        donorJson['canDonate'],
        donorJson['lastDonation'],
        donorJson['leftDonationsInYear'],
        donorJson['firstDonationInYear']);
    return donor;
  }
}
