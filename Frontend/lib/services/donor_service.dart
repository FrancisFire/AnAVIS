import 'dart:convert';

import 'package:anavis/apicontrollers/donor_controller.dart';
import 'package:anavis/models/donor.dart';
import 'package:flutter/cupertino.dart';

class DonorService {
  DonorController _donorController;
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
      DonorCategory cat;
      switch (donor['category']) {
        case "MAN":
          cat = DonorCategory.MAN;
          break;
        case "FERTILEWOMAN":
          cat = DonorCategory.FERTILEWOMAN;
          break;
        case "NONFERTILEWOMAN":
          cat = DonorCategory.NONFERTILEWOMAN;
          break;
      }
      donors.add(new Donor.complete(
          donor['mail'],
          donor['officeMail'],
          cat,
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
    DonorCategory cat;
    switch (parsedJson['category']) {
      case "MAN":
        cat = DonorCategory.MAN;
        break;
      case "FERTILEWOMAN":
        cat = DonorCategory.FERTILEWOMAN;
        break;
      case "NONFERTILEWOMAN":
        cat = DonorCategory.NONFERTILEWOMAN;
        break;
    }

    Donor donor = new Donor.complete(
        parsedJson['mail'],
        parsedJson['officeMail'],
        cat,
        parsedJson['name'],
        parsedJson['surname'],
        parsedJson['birthday'],
        parsedJson['birthPlace'],
        parsedJson['canDonate'],
        parsedJson['lastDonation'],
        parsedJson['leftDonationsInYear'],
        parsedJson['firstDonationInYear']);
    return donor;
  }

  void _setController(BuildContext context) {
    _donorController = new DonorController(context);
  }

  static final DonorService _singleton = DonorService._internal();

  factory DonorService(BuildContext context) {
    _singleton._setController(context);
    return _singleton;
  }

  DonorService._internal();
}
