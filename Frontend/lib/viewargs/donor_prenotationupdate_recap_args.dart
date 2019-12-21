class DonorPrenotationUpdateRecapArgs {
  DonorPrenotationUpdateRecapArgs(
      String office, String time, String nicerTime, String prenotationId) {
    this._office = office;
    this._time = time;
    this._nicerTime = nicerTime;
    this._prenotationId = prenotationId;
  }
  String _office;
  String _time;
  String _nicerTime;
  String _prenotationId;
  String getOffice() {
    return _office;
  }

  String getTime() {
    return _time;
  }

  String getNicerTime() {
    return _nicerTime;
  }

  String getPrenotationId() {
    return _prenotationId;
  }
}
