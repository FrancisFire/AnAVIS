import 'package:anavis/models/timeslot.dart';

class Office {
  String _name;
  Set<TimeSlot> _timeTables;
  Office(String name, Set<TimeSlot> timeTables) {
    this._name = name;
    this._timeTables = timeTables;
  }

  String getName() {
    return _name;
  }

  Set<TimeSlot> getTimeTables() {
    return _timeTables;
  }
}
