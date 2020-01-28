import 'package:anavis/models/office.dart';

class OfficeAddDateslotRecapArgs {
  OfficeAddDateslotRecapArgs(
      int slots, DateTime dateValue, String nicerTime, Office office) {
    this._slots = slots;
    this._nicerTime = nicerTime;
    this._office = office;
    this._dateValue = dateValue;
  }
  String _nicerTime;
  Office _office;
  int _slots;
  DateTime _dateValue;

  int getSlots() {
    return _slots;
  }

  Office getOffice() {
    return _office;
  }

  DateTime getDateValue() {
    return _dateValue;
  }

  String getNicerTime() {
    return _nicerTime;
  }
}
