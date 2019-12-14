class OfficePrenotationTimeViewArgs {
  OfficePrenotationTimeViewArgs(String office, String donor) {
    this._officeName = office;
    this._donor = donor;
  }

  String _officeName;
  String _donor;

  String getOfficeName() {
    return _officeName;
  }

  String getDonor() {
    return _donor;
  }
}
