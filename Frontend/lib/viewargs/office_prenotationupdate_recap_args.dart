import 'package:anavis/models/donor.dart';
import 'package:anavis/models/office.dart';

class OfficePrenotationUpdateRecapArgs {
  OfficePrenotationUpdateRecapArgs(
      Donor donor, String time, String nicerTime, String id, Office office) {
    this._donor = donor;
    this._time = time;
    this._nicerTime = nicerTime;
    this._id = id;
    this._office = office;
  }
  Donor _donor;
  String _time;
  String _nicerTime;
  String _id;
  Office _office;
  Office getOffice() {
    return _office;
  }

  String getId() {
    return _id;
  }

  Donor getDonor() {
    return _donor;
  }

  String getTime() {
    return _time;
  }

  String getNicerTime() {
    return _nicerTime;
  }
}
