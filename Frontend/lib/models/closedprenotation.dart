import 'package:anavis/models/prenotation.dart';

class ClosedPrenotation extends Prenotation {
  String _reportId;
  ClosedPrenotation(
      String id, String officeId, String donorId, String hour, String reportId)
      : _reportId = reportId,
        super.withParams(id, officeId, donorId, hour);
}
