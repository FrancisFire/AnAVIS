import 'package:anavis/models/donor.dart';
import 'package:anavis/models/office.dart';
import 'package:anavis/models/timeslot.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';

class AppState extends ChangeNotifier {
  List<String> _officeNames = new List<String>();
  String _ipReference;
  Set<String> _availableDonorsMailsByOffice = new Set<String>();

  AppState(String ip) {
    _ipReference = ip;
    setOfficeNames();
  }

  void setOfficeNames() async {
    var request = await http.get("http://${_ipReference}:8080/api/office");
    var parsedJson = json.decode(request.body);
    for (var office in parsedJson) {
      _officeNames.add(office['place']);
    }
    notifyListeners();
  }

  Future<void> setAvailableDonorsMailsByOffice(String officeMail) async {
    var request = await http.get(
        "http://${_ipReference}:8080/api/donor/office/$officeMail/available");
    var parsedJson = json.decode(request.body);
    for (var office in parsedJson) {
      _availableDonorsMailsByOffice.add(office['mail']);
    }
    notifyListeners();
  }

  List<String> getOfficeNames() {
    return _officeNames;
  }

  Set<String> getAvailableDonorsMailsByOffice() {
    return _availableDonorsMailsByOffice;
  }

  Future<Donor> getDonorByMail(String donorMail) async {
    var request =
        await http.get("http://${_ipReference}:8080/api/donor/$donorMail");
    var parsedJson = json.decode(request.body);
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

  Future<Office> getOfficeByMail(String officeMail) async {
    var request =
        await http.get("http://${_ipReference}:8080/api/office/$officeMail");
    var parsedJson = json.decode(request.body);
    var officeJson = parsedJson[0];
    Set<TimeSlot> timeTable = new Set<TimeSlot>();
    for (var time in officeJson['donationTimeTable']) {
      timeTable.add(TimeSlot(time['dateTime'], time['donorSlots']));
    }
    Office office =
        new Office.complete(officeJson['mail'], officeJson['place'], timeTable);
    return office;
  }

  void showFlushbar(
      String title, String message, bool isGood, BuildContext context) {
    Flushbar(
      margin: EdgeInsets.all(8),
      borderRadius: 26,
      shouldIconPulse: true,
      title: title,
      icon: isGood
          ? Icon(
              Icons.check,
              size: 28.0,
              color: Colors.green[600],
            )
          : Icon(
              Icons.info_outline,
              size: 28.0,
              color: Colors.red[600],
            ),
      message: message,
      duration: Duration(
        seconds: 6,
      ),
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
    ).show(context);
  }
}
