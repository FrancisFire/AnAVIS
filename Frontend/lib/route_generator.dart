import 'package:anavis/viewargs/donor_prenotationupdate_recap_args.dart';
import 'package:anavis/viewargs/office_prenotation_recap_args.dart';
import 'package:anavis/viewargs/office_prenotation_time_view_args.dart';
import 'package:anavis/views/donor_candonate_view.dart';
import 'package:anavis/views/donor_pendingprenotations_view.dart';
import 'package:anavis/views/donor_prenotations_view.dart';
import 'package:anavis/views/donor_prenotationupdate_recap_view.dart';
import 'package:anavis/views/donor_request_add_views/donor_request_office_view.dart';
import 'package:anavis/views/donor_request_add_views/donor_request_recap_view.dart';
import 'package:anavis/views/donor_request_add_views/donor_request_time_view.dart';
import 'package:anavis/views/donor_view.dart';
import 'package:anavis/views/login_view.dart';
import 'package:anavis/views/office_prenotation_add_views/office_prenotation_donor_view.dart';
import 'package:anavis/views/office_prenotation_add_views/office_prenotation_recap_view.dart';
import 'package:anavis/views/office_prenotation_add_views/office_prenotation_time_view.dart';
import 'package:anavis/views/office_prenotations_view.dart';
import 'package:anavis/views/office_prenotationupdate_recap_view.dart';
import 'package:anavis/views/office_request_view.dart';
import 'package:anavis/views/office_view.dart';
import 'package:flutter/material.dart';

import 'viewargs/donor_request_recap_args.dart';
import 'viewargs/office_prenotationupdate_recap_args.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => LoginView(),
            settings: RouteSettings(
              name: 'LoginView',
            ));

      case '/donor':
        return MaterialPageRoute(
            builder: (_) => DonorView(),
            settings: RouteSettings(
              name: 'DonorView',
            ));

      case '/office':
        return MaterialPageRoute(
            builder: (_) => OfficeView(),
            settings: RouteSettings(
              name: 'OfficeView',
            ));

      case "/office/requests":
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => OfficeRequestView(
                    officeName: args,
                  ),
              settings: RouteSettings(
                name: 'OfficeRequestView',
              ));
        }
        return _errorRoute();

      case "/office/prenotationsview":
        return MaterialPageRoute(
            builder: (_) => OfficePrenotationView(),
            settings: RouteSettings(
              name: 'OfficePrenotation',
            ));

      case '/office/prenotations':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => OfficePrenotationDonorView(
                    officeName: args,
                  ),
              settings: RouteSettings(
                name: 'OfficePrenotationView',
              ));
        }
        return _errorRoute();

      case '/office/prenotations/timeview':
        if (args is OfficePrenotationTimeViewArgs) {
          return MaterialPageRoute(
              builder: (_) => OfficePrenotationTimeView(
                    officeName: args.getOfficeName(),
                    donor: args.getDonor(),
                  ),
              settings: RouteSettings(
                name: 'OfficePrenotationTimeView',
              ));
        }
        return _errorRoute();

      case '/office/prenotations/recap':
        if (args is OfficePrenotationRecapArgs) {
          return MaterialPageRoute(
              builder: (_) => OfficePrenotationRecap(
                    donor: args.getDonor(),
                    time: args.getTime(),
                    nicerTime: args.getNicerTime(),
                  ),
              settings: RouteSettings(
                name: 'OfficePrenotationRecap',
              ));
        }
        return _errorRoute();

      case '/office/prenotationupdate/recap':
        if (args is OfficePrenotationUpdateRecapArgs) {
          return MaterialPageRoute(
              builder: (_) => OfficePrenotationUpdateRecap(
                    donor: args.getDonor(),
                    time: args.getTime(),
                    nicerTime: args.getNicerTime(),
                    id: args.getId(),
                    officeName: args.getOfficeName(),
                  ),
              settings: RouteSettings(
                name: 'OfficePrenotationUpdateRecap',
              ));
        }
        return _errorRoute();
      case '/donor/candonate':
        return MaterialPageRoute(
            builder: (_) => DonorCanDonateView(),
            settings: RouteSettings(
              name: 'DonorCanDonateView',
            ));

      case "/donor/prenotationsview":
        return MaterialPageRoute(
            builder: (_) => DonorPrenotationView(),
            settings: RouteSettings(
              name: 'DonorPrenotationView',
            ));

      case "/donor/pendingprenotationsview":
        return MaterialPageRoute(
            builder: (_) => DonorPendingPrenotationView(),
            settings: RouteSettings(
              name: 'DonorPendingPrenotationView',
            ));

      case '/donor/officerequest':
        return MaterialPageRoute(
            builder: (_) => DonorRequestOfficeView(),
            settings: RouteSettings(
              name: 'DonorRequestOfficeView',
            ));

      case '/donor/officerequest/timeview':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => DonorRequestTimeView(
                    office: args,
                  ),
              settings: RouteSettings(
                name: 'DonorRequestTimeView',
              ));
        }
        return _errorRoute();

      case '/donor/officerequest/recap':
        if (args is DonorRequestRecapArgs) {
          return MaterialPageRoute(
              builder: (_) => DonorRequestRecap(
                    office: args.getOffice(),
                    time: args.getTime(),
                    nicerTime: args.getNicerTime(),
                  ),
              settings: RouteSettings(
                name: 'DonorRequestRecap',
              ));
        }
        return _errorRoute();

      case '/donor/prenotationupdate/recap':
        if (args is DonorPrenotationUpdateRecapArgs) {
          return MaterialPageRoute(
              builder: (_) => DonorPrenotationUpdateRecap(
                    office: args.getOffice(),
                    time: args.getTime(),
                    nicerTime: args.getNicerTime(),
                    prenotationId: args.getPrenotationId(),
                  ),
              settings: RouteSettings(
                name: 'DonorPrenotationUpdateRecap',
              ));
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          automaticallyImplyLeading: false,
          elevation: 26,
          title: Text(
            'Errore nel routing',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Image.network(
                'https://am22.akamaized.net/tms/cnt/uploads/2019/12/Baby-Yoda-With-His-Little-Cup-Is-All-of-Us.jpeg',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      );
    });
  }
}
