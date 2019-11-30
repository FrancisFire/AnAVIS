import 'package:anavis/views/donor_candonate_view.dart';
import 'package:anavis/views/donor_request_add_views/donor_request_office_view.dart';
import 'package:anavis/views/donor_request_add_views/donor_request_recap.dart';
import 'package:anavis/views/donor_request_add_views/donor_request_time_view.dart';
import 'package:anavis/views/donor_view.dart';
import 'package:anavis/views/login_view.dart';
import 'package:anavis/views/office_request_view.dart';
import 'package:anavis/views/office_view.dart';
import 'package:flutter/material.dart';

import 'model/donor_request_recap_args.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginView());

      case '/donor':
        return MaterialPageRoute(builder: (_) => DonorView());

      case '/office':
        return MaterialPageRoute(builder: (_) => OfficeView());

      case '/office/requests':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => OfficeRequestView(
              officeName: args,
            ),
          );
        }
        return _errorRoute();

      case '/donor/candonate':
        return MaterialPageRoute(builder: (_) => DonorCanDonateView());

      case '/donor/officerequest':
        return MaterialPageRoute(builder: (_) => DonorRequestOfficeView());

      case '/donor/officerequest/timeview':
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => DonorRequestTimeView(
              office: args,
            ),
          );
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
          );
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
          title: Text('Errore nel routing'),
        ),
        body: Center(
          child: Text('ERRORE NEL ROUTING'),
        ),
      );
    });
  }
}
