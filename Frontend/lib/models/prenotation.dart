class Prenotation {
  String _id;
  String _officeId;
  String _donorId;
  String _hour;
  bool _confirmed;
  Prenotation(
      String id, String officeId, String donorId, String hour, bool confirmed) {
    this._id = id;
    this._officeId = officeId;
    this._donorId = donorId;
    this._hour = hour;
    this._confirmed = confirmed;
  }

  String getId() {
    return _id;
  }

  String getOfficeId() {
    return _officeId;
  }

  String getDonorId() {
    return _donorId;
  }

  String getHour() {
    return _hour;
  }

  bool isConfirmed() {
    return _confirmed;
  }
}
