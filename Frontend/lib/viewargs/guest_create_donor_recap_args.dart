import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/models/donor.dart';

class GuestCreateDonorRecapArgs {
  AuthCredentials _credentials;
  Donor _donor;
  GuestCreateDonorRecapArgs(AuthCredentials credentials, Donor donor) {
    this._credentials = credentials;
    this._donor = donor;
  }

  AuthCredentials getCredentials() {
    return _credentials;
  }

  Donor getDonor() {
    return _donor;
  }
}
