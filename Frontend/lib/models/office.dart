import 'package:anavis/models/timeslot.dart';

class Office {
  String _mail;
  String _place;
  Set<TimeSlot> _timeTables;
  Office(String mail, String place) {
    this._mail = mail;
    this._place = place;
  }

  Office.complete(String mail, String place, Set<TimeSlot> timeTables) {
    this._mail = mail;
    this._place = place;
    this._timeTables = timeTables;
  }

  String getMail() {
    return _mail;
  }

  Set<TimeSlot> getTimeTables() {
    return _timeTables;
  }

  String getPlace() {
    return _place;
  }
}
