class Donor {
  Donor(String mail, String officeMail, DonorCategory category, String name,
      String surname, String birthday, String birthPlace) {
    this._mail = mail;
    this._officeMail = officeMail;
    this._category = category;
    this._name = name;
    this._surname = surname;
    this._birthday = birthday;
    this._birthPlace = birthPlace;
  }

  Donor.complete(
      String mail,
      String officeMail,
      DonorCategory category,
      String name,
      String surname,
      String birthday,
      String birthPlace,
      bool canDonate,
      String lastDonation,
      int leftDonationsInYear,
      String firstDonationInYear) {
    this._mail = mail;
    this._officeMail = officeMail;
    this._category = category;
    this._name = name;
    this._surname = surname;
    this._birthday = birthday;
    this._birthPlace = birthPlace;
    this._canDonate = canDonate;
    this._lastDonation = lastDonation;
    this._leftDonationsInYear = leftDonationsInYear;
    this._firstDonationInYear = firstDonationInYear;
  }

  String _mail;
  String _officeMail;
  bool _canDonate;
  String _lastDonation;
  DonorCategory _category;
  String _name;
  String _surname;
  String _birthday;
  String _birthPlace;
  int _leftDonationsInYear;
  String _firstDonationInYear;

  String getMail() {
    return _mail;
  }

  String getOfficeMail() {
    return _officeMail;
  }

  bool canDonate() {
    return _canDonate;
  }

  String getLastDonation() {
    return _lastDonation;
  }

  DonorCategory getCategory() {
    return _category;
  }

  String getName() {
    return _name;
  }

  String getSurname() {
    return _surname;
  }

  String getBirthday() {
    return _birthday;
  }

  String getBirthPlace() {
    return _birthPlace;
  }

  int getLeftDonationsInYear() {
    return _leftDonationsInYear;
  }

  String getFirstDonationInYear() {
    return _firstDonationInYear;
  }
}

enum DonorCategory { MAN, FERTILEWOMAN, NONFERTILEWOMAN }
