import 'package:anavis/models/donor.dart';
import 'package:anavis/models/office.dart';

class OfficePrenotationTimeViewArgs {
  OfficePrenotationTimeViewArgs(String donor, Office office) {
    this._donorMail = donor;
    this._office = office;
  }

  String _donorMail;
  Office _office;

  String getDonorMail() {
    return _donorMail;
  }

  Office getOffice() {
    return _office;
  }
}
