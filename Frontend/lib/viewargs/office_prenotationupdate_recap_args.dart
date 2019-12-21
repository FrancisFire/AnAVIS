class OfficePrenotationUpdateRecapArgs {
  OfficePrenotationUpdateRecapArgs(String donor, String time, String nicerTime,
      String id, String officeName) {
    this._donor = donor;
    this._time = time;
    this._nicerTime = nicerTime;
    this._id = id;
    this._officeName = officeName;
  }
  String _donor;
  String _time;
  String _nicerTime;
  String _id;
  String _officeName;
  String getOfficeName() {
    return _officeName;
  }

  String getId() {
    return _id;
  }

  String getDonor() {
    return _donor;
  }

  String getTime() {
    return _time;
  }

  String getNicerTime() {
    return _nicerTime;
  }
}
