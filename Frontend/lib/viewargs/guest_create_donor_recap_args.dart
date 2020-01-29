import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/models/donor.dart';

class GuestCreateDonorRecapArgs {
  AuthCredentials _credentials;
  Donor _donor;
  String _officeName;
  GuestCreateDonorRecapArgs(
      AuthCredentials credentials, Donor donor, String officeName) {
    this._credentials = credentials;
    this._donor = donor;
    this._officeName = officeName;
  }

  AuthCredentials getCredentials() {
    return _credentials;
  }

  Donor getDonor() {
    return _donor;
  }

  String getOfficeName() {
    return _officeName;
  }
}
