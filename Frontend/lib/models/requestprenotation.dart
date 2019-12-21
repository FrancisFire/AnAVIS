import 'package:anavis/models/prenotation.dart';

class RequestPrenotation extends Prenotation {
  RequestPrenotation(String id, String officeId, String donorId, String hour)
      : super.withParams(id, officeId, donorId, hour);
}
