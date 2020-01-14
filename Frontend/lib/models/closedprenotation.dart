import 'package:anavis/models/prenotation.dart';

class ClosedPrenotation extends Prenotation {
  String _reportId;
  ClosedPrenotation(String id, String officeMail, String donorMail, String hour,
      String reportId)
      : _reportId = reportId,
        super.withParams(id, officeMail, donorMail, hour);

  String getReportId() {
    return _reportId;
  }
}
