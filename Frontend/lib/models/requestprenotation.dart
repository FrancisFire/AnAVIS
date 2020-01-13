import 'package:anavis/models/prenotation.dart';

class RequestPrenotation extends Prenotation {
  RequestPrenotation(
      String id, String officeMail, String donorMail, String hour)
      : super.withParams(id, officeMail, donorMail, hour);
}
