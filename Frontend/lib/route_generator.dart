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

      case '/donor/candonate':
        return MaterialPageRoute(
            builder: (_) => DonorCanDonateView(),
            settings: RouteSettings(
              name: 'DonorCanDonateView',
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
                'http://docenti.unicam.it/imgprof/1103/img_1078.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      );
    });
  }
}
