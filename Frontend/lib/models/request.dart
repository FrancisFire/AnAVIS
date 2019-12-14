class Request {
  String _id;
  String _officeId;
  String _donorId;
  String _hour;
  Request(String id, String officeId, String donorId, String hour) {
    this._id = id;
    this._officeId = officeId;
    this._donorId = donorId;
    this._hour = hour;
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
}
