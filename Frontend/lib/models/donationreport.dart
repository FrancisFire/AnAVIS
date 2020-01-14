class DonationReport {
  String _reportId;
  String _reportFile;
  String _donorMail;
  String _officeMail;
  String _date;
  DonationReport(String reportId, String reportFile, String donorMail,
      String officeMail, String date) {
    this._date = date;
    this._donorMail = donorMail;
    this._officeMail = officeMail;
    this._reportFile = reportFile;
    this._reportId = reportId;
  }

  String getReportId() {
    return _reportId;
  }

  String getReportFile() {
    return _reportFile;
  }

  String getDonorMail() {
    return _donorMail;
  }

  String getOfficeMail() {
    return _officeMail;
  }

  String getDate() {
    return _date;
  }
}
