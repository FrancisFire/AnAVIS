import 'package:anavis/models/prenotation.dart';

class ActivePrenotation extends Prenotation {
  bool _confirmed;
  ActivePrenotation(
      String id, String officeMail, String donorMail, String hour, bool conf)
      : _confirmed = conf,
        super.withParams(id, officeMail, donorMail, hour);
  bool isConfirmed() {
    return _confirmed;
  }
}
