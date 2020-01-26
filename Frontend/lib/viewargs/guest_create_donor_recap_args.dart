import 'package:anavis/models/donor.dart';

class GuestCreateDonorRecapArgs {
  String _email;
  String _password;
  Donor _donor;
  GuestCreateDonorRecapArgs(String email, String password, Donor donor) {
    this._email = email;
    this._password = password;
    this._donor = donor;
  }

  String getEmail() {
    return _email;
  }

  String getPassword() {
    return _password;
  }

  Donor getDonor() {
    return _donor;
  }
}
