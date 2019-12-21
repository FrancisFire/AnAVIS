class DonorRequestRecapArgs {
  DonorRequestRecapArgs(String office, String time, String nicerTime) {
    this._office = office;
    this._time = time;
    this._nicerTime = nicerTime;
  }
  String _office;
  String _time;
  String _nicerTime;
  String getOffice() {
    return _office;
  }

  String getTime() {
    return _time;
  }

  String getNicerTime() {
    return _nicerTime;
  }
}
