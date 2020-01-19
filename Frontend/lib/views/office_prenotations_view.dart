import 'package:anavis/models/activeprenotation.dart';
import 'package:anavis/models/office.dart';
import 'package:anavis/providers/app_state.dart';
import 'package:anavis/services/prenotation_service.dart';
import 'package:anavis/views/widgets/button_card_bottom.dart';
import 'package:anavis/views/widgets/card_prenotation_request.dart';
import 'package:anavis/views/widgets/confirm_alert_dialog.dart';
import 'package:anavis/views/widgets/confirmation_flushbar.dart';
import 'package:anavis/views/widgets/custom_dialog_mod_prenotation.dart';
import 'package:anavis/views/widgets/custom_dialog_upload_file.dart';
import 'package:anavis/views/widgets/loading_circular.dart';
import 'package:anavis/views/widgets/painter.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OfficePrenotationView extends StatefulWidget {
  final Office office;
  OfficePrenotationView({@required this.office});
  @override
  _OfficePrenotationViewState createState() => _OfficePrenotationViewState();
}

class _OfficePrenotationViewState extends State<OfficePrenotationView> {
  List<ActivePrenotation> _officePrenotations;
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    await this.getPrenotations();
    _refreshController.refreshCompleted();
  }

  Future<void> getPrenotations() async {
    _officePrenotations = await PrenotationService(context)
        .getPrenotationsByOffice(widget.office.getMail());
  }

  Future<void> initFuture() async {
    await Future.wait([
      this.getPrenotations(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Prenotazioni per ${widget.office.getPlace()}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 8,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.red,
      ),
      body: CustomPaint(
        painter: Painter(
          first: Colors.red[100],
          second: Colors.orange[200],
          background: Colors.white,
        ),
        child: Center(
          child: FutureBuilder(
            future: this.initFuture(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return new RequestCircularLoading();
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return new RequestCircularLoading();
                case ConnectionState.done:
                  if (snapshot.hasError) return new RequestCircularLoading();
                  if (_officePrenotations.isEmpty) {
                    return new Center(
                      child: Padding(
                        padding: const EdgeInsets.all(
                          18.0,
                        ),
                        child: Card(
                          elevation: 42,
                          shape: RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(
                              16.0,
                            ),
                            child: Text(
                              "Non sono presenti prenotazioni di donazione al momento, si prega di riprovare più tardi",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                  return SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onRefresh,
                    enablePullDown: true,
                    enablePullUp: false,
                    header: WaterDropMaterialHeader(
                      backgroundColor: Colors.red[900],
                    ),
                    child: ListView.builder(
                      itemCount: _officePrenotations.length,
                      itemBuilder: (context, index) {
                        return CardForPrenotationAndRequest(
                          email: _officePrenotations[index].getDonorMail(),
                          hour: _officePrenotations[index].getHour(),
                          id: _officePrenotations[index].getId(),
                          afterTitle: _officePrenotations[index].isConfirmed()
                              ? Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : Icon(
                                  Icons.error,
                                  color: Colors.red,
                                ),
                          buttonBar: ButtonBar(
                            children: <Widget>[
                              ButtonForCardBottom(
                                icon: Icon(
                                  Icons.file_upload,
                                  color: Colors.white,
                                ),
                                color: Colors.indigo,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomDialogUploadFile(
                                      prenotation: _officePrenotations[index],
                                    ),
                                  );
                                },
                                title: 'Chiudi',
                              ),
                              ButtonForCardBottom(
                                icon: Icon(
                                  Icons.mode_edit,
                                  color: Colors.white,
                                ),
                                color: Colors.orange,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        DialogModificationPrenotation(
                                      office: widget.office,
                                      prenotationId:
                                          _officePrenotations[index].getId(),
                                      donorMail: _officePrenotations[index]
                                          .getDonorMail(),
                                    ),
                                  );
                                },
                                title: 'Modifica',
                              ),
                              ButtonForCardBottom(
                                icon: Icon(
                                  Icons.cancel,
                                ),
                                color: Colors.red,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ConfirmAlertDialog(
                                        denyFunction: () {
                                          Navigator.popUntil(
                                              context,
                                              ModalRoute.withName(
                                                  'OfficeView'));
                                          ConfirmationFlushbar(
                                            "Operazione annullata",
                                            "L'operazione è stata annulata correttamente",
                                            false,
                                          ).show(context);
                                        },
                                        confirmFunction: () {
                                          PrenotationService(context)
                                              .removePrenotation(
                                                  _officePrenotations[index]
                                                      .getId())
                                              .then((status) {
                                            if (status) {
                                              Navigator.popUntil(
                                                  context,
                                                  ModalRoute.withName(
                                                      'OfficeView'));
                                              ConfirmationFlushbar(
                                                "Operazione effettuata",
                                                "L'operazione è stata effettuata correttamente",
                                                true,
                                              ).show(context);
                                            } else {
                                              Navigator.popUntil(
                                                  context,
                                                  ModalRoute.withName(
                                                      'OfficeView'));
                                              ConfirmationFlushbar(
                                                "Operazione non effettuata",
                                                "C'è stato un errore nell'esecuzione dell'operazione",
                                                false,
                                              ).show(context);
                                            }
                                          });
                                        },
                                      );
                                    },
                                  );
                                },
                                title: 'Elimina',
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
