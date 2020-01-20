import 'dart:convert';

import 'package:anavis/apicontrollers/office_controller.dart';
import 'package:anavis/models/office.dart';
import 'package:anavis/models/timeslot.dart';
import 'package:flutter/cupertino.dart';

class OfficeService {
  OfficeController _officeController;

  Future<List<Office>> getOffices() async {
    List<Office> offices = new List<Office>();
    String controllerJson = await _officeController.getOffices();
    var parsedJson = json.decode(controllerJson);
    for (var office in parsedJson) {
      Set<TimeSlot> timeTable = new Set<TimeSlot>();
      for (var time in office['donationTimeTable']) {
        timeTable.add(TimeSlot(
          time['dateTime'],
          time['donorSlots'],
        ));
      }
      offices.add(new Office.complete(
        office['mail'],
        office['place'],
        timeTable,
      ));
    }
    return offices;
  }

  Future<List<TimeSlot>> getDonationsTimeTable(String officeMail) async {
    List<TimeSlot> timeTables = new List<TimeSlot>();
    String controllerJson =
        await _officeController.getDonationsTimeTable(officeMail);
    var parsedJson = json.decode(controllerJson);
    for (var time in parsedJson) {
      timeTables.add(TimeSlot(
        time['dateTime'],
        time['donorSlots'],
      ));
    }
    return timeTables;
  }

  Future<List<TimeSlot>> getAvailableTimeTablesByOffice(
      String officeMail) async {
    List<TimeSlot> available = new List<TimeSlot>();
    List<TimeSlot> timeTable = await this.getDonationsTimeTable(officeMail);
    for (TimeSlot slot in timeTable) {
      if (slot.getSlots() > 0) {
        available.add(slot);
      }
    }
    return available;
  }

  Future<bool> addTimeSlot(String officeMail, TimeSlot timeSlot) async {
    String controllerJson =
        await _officeController.addTimeSlot(officeMail, timeSlot);
    return controllerJson == 'true';
  }

  Future<Office> getOfficeByMail(String officeMail) async {
    String controllerJson = await _officeController.getOfficeByMail(officeMail);
    var parsedJson = json.decode(controllerJson);
    Set<TimeSlot> timeTable = new Set<TimeSlot>();
    for (var time in parsedJson['donationTimeTable']) {
      timeTable.add(TimeSlot(
        time['dateTime'],
        time['donorSlots'],
      ));
    }
    Office office = new Office.complete(
      parsedJson['mail'],
      parsedJson['place'],
      timeTable,
    );
    return office;
  }

  Future<Map<String, String>> getOfficeMailsAndNames() async {
    Map<String, String> officeMailsAndNames = new Map<String, String>();
    List<Office> offices = await this.getOffices();
    for (var office in offices) {
      officeMailsAndNames.putIfAbsent(
          office.getMail(), () => office.getPlace());
    }
    return officeMailsAndNames;
  }

  void _setController(BuildContext context) {
    _officeController = new OfficeController(context);
  }

  static final OfficeService _singleton = OfficeService._internal();

  factory OfficeService(BuildContext context) {
    _singleton._setController(context);
    return _singleton;
  }

  OfficeService._internal();
}
