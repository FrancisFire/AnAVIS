class TimeSlot {
  String _dateTime;
  int _donorSlots;
  TimeSlot(String date, int slots) {
    this._dateTime = date;
    this._donorSlots = slots;
  }

  String getDateTime() {
    return _dateTime;
  }

  int getSlots() {
    return _donorSlots;
  }
}
