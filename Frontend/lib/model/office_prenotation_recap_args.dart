class OfficePrenotationRecapArgs {
  OfficePrenotationRecapArgs(String donor, String time, String nicerTime) {
    this._donor = donor;
    this._time = time;
    this._nicerTime = nicerTime;
  }
  String _donor;
  String _time;
  String _nicerTime;

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
