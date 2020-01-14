abstract class Prenotation {
  String _id;
  String _officeMail;
  String _donorMail;
  String _hour;
  Prenotation.withParams(
      String id, String officeMail, String donorMail, String hour) {
    this._id = id;
    this._officeMail = officeMail;
    this._donorMail = donorMail;
    this._hour = hour;
  }

  Prenotation() {}
  String getId() {
    return _id;
  }

  String getOfficeMail() {
    return _officeMail;
  }

  String getDonorMail() {
    return _donorMail;
  }

  String getHour() {
    return _hour;
  }
}
