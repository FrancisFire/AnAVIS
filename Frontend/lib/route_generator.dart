import 'package:anavis/models/authcredentials.dart';
import 'package:anavis/viewargs/admin_create_users_recap_args.dart';
import 'package:anavis/viewargs/admin_update_users_args.dart';
import 'package:anavis/viewargs/admin_update_users_recap_args.dart';
import 'package:anavis/viewargs/donor_prenotationupdate_recap_args.dart';
import 'package:anavis/viewargs/guest_create_donor_recap_args.dart';
import 'package:anavis/viewargs/office_add_dateslot_recap_args.dart';
import 'package:anavis/viewargs/office_prenotation_recap_args.dart';
import 'package:anavis/viewargs/office_prenotation_time_view_args.dart';
import 'package:anavis/views/admin_crud/admin_create_users.dart';
import 'package:anavis/views/admin_crud/admin_create_users_recap.dart';
import 'package:anavis/views/admin_crud/admin_manage_user.dart';
import 'package:anavis/views/admin_crud/admin_update_users.dart';
import 'package:anavis/views/admin_crud/admin_update_users_recap.dart';
import 'package:anavis/views/admin_view.dart';
import 'package:anavis/views/donor_candonate_view.dart';
import 'package:anavis/views/donor_pendingprenotations_view.dart';
import 'package:anavis/views/donor_prenotations_view.dart';
import 'package:anavis/views/donor_prenotationupdate_recap_view.dart';
import 'package:anavis/views/donor_request_add_views/donor_request_office_view.dart';
import 'package:anavis/views/donor_request_add_views/donor_request_recap_view.dart';
import 'package:anavis/views/donor_request_add_views/donor_request_time_view.dart';
import 'package:anavis/views/donor_request_view.dart';
import 'package:anavis/views/donor_view.dart';
import 'package:anavis/views/guest_views/guest_create_donors.dart';
import 'package:anavis/views/guest_views/guest_create_donors_recap.dart';
import 'package:anavis/views/login_view.dart';
import 'package:anavis/views/office_add_dateslot_recap_view.dart';
import 'package:anavis/views/office_add_dateslot_view.dart';
import 'package:anavis/views/office_prenotation_add_views/office_prenotation_donor_view.dart';
import 'package:anavis/views/office_prenotation_add_views/office_prenotation_recap_view.dart';
import 'package:anavis/views/office_prenotation_add_views/office_prenotation_time_view.dart';
import 'package:anavis/views/office_prenotations_view.dart';
import 'package:anavis/views/office_prenotationupdate_recap_view.dart';
import 'package:anavis/views/office_request_view.dart';
import 'package:anavis/views/office_view.dart';
import 'package:flutter/material.dart';

import 'models/donor.dart';
import 'models/office.dart';
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

      case '/admin':
        return MaterialPageRoute(
            builder: (_) => AdminView(),
            settings: RouteSettings(
              name: 'AdminView',
            ));

      case '/admin/createuser':
        return MaterialPageRoute(
            builder: (_) => AdminCreateUserView(),
            settings: RouteSettings(
              name: 'AdminCreateUser',
            ));

      case '/guest/createuser':
        if (args is AuthCredentials) {
          return MaterialPageRoute(
              builder: (_) => GuestCreateDonorView(
                    credentials: args,
                  ),
              settings: RouteSettings(
                name: 'GuestCreateUser',
              ));
        }
        return _errorRoute();

      case '/guest/createuser/recap':
        if (args is GuestCreateDonorRecapArgs) {
          return MaterialPageRoute(
              builder: (_) => GuestCreateDonorRecap(
                    donor: args.getDonor(),
                    credentials: args.getCredentials(),
                  ),
              settings: RouteSettings(
                name: 'GuestCreateUserRecap',
              ));
        }
        return _errorRoute();

      case '/admin/updateuser':
        if (args is AdminUpdateArgs) {
          return MaterialPageRoute(
              builder: (_) => AdminUpdateUserView(
                    oldMail: args.getEmail(),
                    role: args.getRole(),
                  ),
              settings: RouteSettings(
                name: 'AdminCreateUser',
              ));
        }
        return _errorRoute();
      case '/admin/createuser/recap':
        if (args is AdminCreateRecapArgs) {
          return MaterialPageRoute(
              builder: (_) => AdminCreateRecap(
                    city: args.getCity(),
                    email: args.getEmail(),
                    password: args.getPassword(),
                  ),
              settings: RouteSettings(
                name: 'AdminCreateUser',
              ));
        }
        return _errorRoute();

      case '/admin/updateuser/recap':
        if (args is AdminUpdateRecapArgs) {
          return MaterialPageRoute(
              builder: (_) => AdminUpdateRecap(
                    email: args.getEmail(),
                    password: args.getPassword(),
                    role: args.getRole(),
                  ),
              settings: RouteSettings(
                name: 'AdminCreateUser',
              ));
        }
        return _errorRoute();

      case '/admin/users':
        return MaterialPageRoute(
            builder: (_) => AdminManageUserView(),
            settings: RouteSettings(
              name: 'AdminShowUser',
            ));

      case '/office':
        return MaterialPageRoute(
            builder: (_) => OfficeView(),
            settings: RouteSettings(
              name: 'OfficeView',
            ));

      case "/office/requests":
        if (args is Office) {
          return MaterialPageRoute(
              builder: (_) => OfficeRequestView(
                    office: args,
                  ),
              settings: RouteSettings(
                name: 'OfficeRequestView',
              ));
        }
        return _errorRoute();

      case "/office/prenotationsview":
        if (args is Office) {
          return MaterialPageRoute(
              builder: (_) => OfficePrenotationView(
                    office: args,
                  ),
              settings: RouteSettings(
                name: 'OfficePrenotationView',
              ));
        }
        return _errorRoute();

      case "/office/insertdateslotview":
        if (args is Office) {
          return MaterialPageRoute(
              builder: (_) => OfficeAddDateslotView(
                    office: args,
                  ),
              settings: RouteSettings(
                name: 'OfficeAddDateslotView',
              ));
        }
        return _errorRoute();

      case '/office/insertdateslotview/recap':
        if (args is OfficeAddDateslotRecapArgs) {
          return MaterialPageRoute(
              builder: (_) => OfficeAddDateslotRecapView(
                    dateValue: args.getDateValue(),
                    nicerTime: args.getNicerTime(),
                    office: args.getOffice(),
                    slots: args.getSlots(),
                  ),
              settings: RouteSettings(
                name: 'OfficePrenotationRecap',
              ));
        }
        return _errorRoute();

      case '/office/prenotations':
        if (args is Office) {
          return MaterialPageRoute(
              builder: (_) => OfficePrenotationDonorView(
                    office: args,
                  ),
              settings: RouteSettings(
                name: 'OfficeNewPrenotation',
              ));
        }
        return _errorRoute();

      case '/office/prenotations/timeview':
        if (args is OfficePrenotationTimeViewArgs) {
          return MaterialPageRoute(
              builder: (_) => OfficePrenotationTimeView(
                    donorMail: args.getDonorMail(),
                    office: args.getOffice(),
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
                    office: args.getOffice(),
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
                    office: args.getOffice(),
                  ),
              settings: RouteSettings(
                name: 'OfficePrenotationUpdateRecap',
              ));
        }
        return _errorRoute();
      case '/donor/candonate':
        if (args is Donor) {
          return MaterialPageRoute(
              builder: (_) => DonorCanDonateView(
                    donor: args,
                  ),
              settings: RouteSettings(
                name: 'DonorCanDonateView',
              ));
        }
        return _errorRoute();

      case "/donor/prenotationsview":
        if (args is Donor) {
          return MaterialPageRoute(
              builder: (_) => DonorPrenotationView(
                    donor: args,
                  ),
              settings: RouteSettings(
                name: 'DonorPrenotationView',
              ));
        }
        return _errorRoute();

      case "/donor/requestsview":
        if (args is Donor) {
          return MaterialPageRoute(
              builder: (_) => DonorRequestView(
                    donor: args,
                  ),
              settings: RouteSettings(
                name: 'DonorRequestView',
              ));
        }
        return _errorRoute();

      case "/donor/pendingprenotationsview":
        if (args is Donor) {
          return MaterialPageRoute(
              builder: (_) => DonorPendingPrenotationView(
                    donor: args,
                  ),
              settings: RouteSettings(
                name: 'DonorPendingPrenotationView',
              ));
        }
        return _errorRoute();

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
