import 'package:anavis/models/office.dart';

class OfficePrenotationRecapArgs {
  OfficePrenotationRecapArgs(
      String donor, String time, String nicerTime, Office office) {
    this._donor = donor;
    this._time = time;
    this._nicerTime = nicerTime;
    this._office = office;
  }
  String _donor;
  String _time;
  String _nicerTime;
  Office _office;
  String getDonor() {
    return _donor;
  }

  Office getOffice() {
    return _office;
  }

  String getTime() {
    return _time;
  }

  String getNicerTime() {
    return _nicerTime;
  }
}
