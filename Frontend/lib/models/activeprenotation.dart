import 'package:anavis/models/prenotation.dart';

class ActivePrenotation extends Prenotation {
  bool _confirmed;
  ActivePrenotation(
      String id, String officeId, String donorId, String hour, bool conf)
      : _confirmed = conf,
        super.withParams(id, officeId, donorId, hour);
  bool isConfirmed() {
    return _confirmed;
  }
}
