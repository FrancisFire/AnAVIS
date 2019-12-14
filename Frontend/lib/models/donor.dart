class Donor {
  Donor(String mail, String officeId, bool canDonate) {
    this._mail = mail;
    this._officeId = officeId;
    this._canDonate = canDonate;
  }
  String _mail;
  String _officeId;
  bool _canDonate;
  String getMail() {
    return _mail;
  }

  String getOfficeId() {
    return _officeId;
  }

  bool canDonate() {
    return _canDonate;
  }
}
