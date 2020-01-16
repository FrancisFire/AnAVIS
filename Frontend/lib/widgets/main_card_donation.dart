import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:anavis/models/closedprenotation.dart';
import 'package:anavis/models/donationreport.dart';
import 'package:anavis/providers/current_donor_state.dart';
import 'package:anavis/widgets/value_blood_info.dart';
import 'package:date_format/date_format.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MainCardDonorRecapDonation extends StatefulWidget {
  final ClosedPrenotation closedPrenotation;

  MainCardDonorRecapDonation({
    @required this.closedPrenotation,
  });

  @override
  _MainCardDonorRecapDonationState createState() =>
      _MainCardDonorRecapDonationState();
}

class _MainCardDonorRecapDonationState
    extends State<MainCardDonorRecapDonation> {
  final DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  List<int> selectedSpots = [];
  int touchedIndex;
  int lastPanStartOnIndex = -1;

  bool showLegend = true;

  Future<File> _createFileFromString(String encoded, String filename) async {
    Uint8List bytes = base64.decode(encoded);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename.pdf');
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 7,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(
          Radius.circular(26.0),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Chip(
                    avatar: CircleAvatar(
                      backgroundColor: Colors.grey.shade800,
                      child: Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.white,
                      ),
                    ),
                    label: Text(formatDate(
                        dateFormat.parse(widget.closedPrenotation.getHour()), [
                      yyyy,
                      '-',
                      mm,
                      '-',
                      dd,
                    ])),
                  ),
                  GestureDetector(
                    onTap: () async {
                      String dir =
                          (await getApplicationDocumentsDirectory()).path;
                      DonationReport donationReport =
                          await Provider.of<CurrentDonorState>(context)
                              .getReportByDonationID(
                        widget.closedPrenotation.getId(),
                      );
                      await _createFileFromString(
                          donationReport.getReportFile(),
                          donationReport.getReportId());
                      OpenFile.open('$dir/${donationReport.getReportId()}.pdf');
                    },
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.grey.shade800,
                      child: Icon(
                        Icons.file_download,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                ),
                color: Colors.orange[100],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Chip(
                      backgroundColor: Colors.orange[700],
                      avatar: CircleAvatar(
                        backgroundColor: Colors.orangeAccent,
                        child: Text(
                          "ID",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      label: Text(
                        widget.closedPrenotation.getId(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Chip(
                      backgroundColor: Colors.orange[700],
                      avatar: CircleAvatar(
                          backgroundColor: Colors.orangeAccent,
                          child: Icon(
                            Icons.email,
                            color: Colors.white,
                            size: 16,
                          )),
                      label: Text(
                        widget.closedPrenotation.getOfficeMail(),
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 4,
                child: Center(
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                              showLegend = true;
                            } else {
                              touchedIndex =
                                  pieTouchResponse.touchedSectionIndex;
                              showLegend = false;
                            }
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 5,
                      centerSpaceRadius: 30,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              showLegend
                  ? buildLegend()
                  : InfoValueBlood(
                      value: 42,
                      indexValue: touchedIndex,
                    )
            ],
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final double radius = isTouched ? 60 : 50;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: 40,
            showTitle: false,
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.orange,
            value: 30,
            showTitle: false,
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.grey,
            value: 15,
            showTitle: false,
            radius: radius,
          );
        case 3:
          return PieChartSectionData(
            color: Colors.green,
            value: 15,
            showTitle: false,
            radius: radius,
          );
        default:
          return null;
      }
    });
  }

  Column buildLegend() {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.red,
              ),
              backgroundColor: Colors.red.withOpacity(0.3),
              label: Text(
                'Globuli rossi',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.grey,
              ),
              backgroundColor: Colors.grey.withOpacity(0.3),
              label: Text(
                'Globuli bianchi',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.orange,
              ),
              backgroundColor: Colors.orange.withOpacity(0.3),
              label: Text(
                'Piastrine',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            Chip(
              avatar: CircleAvatar(
                backgroundColor: Colors.green,
              ),
              backgroundColor: Colors.green.withOpacity(0.3),
              label: Text(
                'Colesterolo',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
