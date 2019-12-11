import 'package:anavis/model/current_office_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:circle_wheel_scroll/circle_wheel_scroll_view.dart';
import 'package:provider/provider.dart';

class OfficePrenotationView extends StatefulWidget {
  @override
  _OfficePrenotationViewState createState() => _OfficePrenotationViewState();
}

class _OfficePrenotationViewState extends State<OfficePrenotationView> {
  CircleListScrollView buildListCircle(List<dynamic> list) {
    List<Widget> elements = new List<Widget>();
    for (var item in list) {
      elements.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26),
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Id: ${item['id']}"),
                subtitle: Text("Donor: ${item['donor']['mail']}"),
              ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('Modifica'),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        // new Container(
        //   child: Column(
        //     children: <Widget>[
        //       Text(),
        //       Text(),
        //       Text("Hour: "),
        //     ],
        //   ),
        // ),
      );
    }
    return CircleListScrollView(
      children: elements,
      physics: CircleFixedExtentScrollPhysics(),
      axis: Axis.horizontal,
      itemExtent: 150,
      radius: MediaQuery.of(context).size.width * 0.6,
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FutureBuilder<List<dynamic>>(
          future: Provider.of<CurrentOfficeState>(context)
              .getOfficePrenotationsJson(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return new RequestCircularLoading();
              case ConnectionState.active:
              case ConnectionState.waiting:
                return new RequestCircularLoading();
              case ConnectionState.done:
                if (snapshot.hasError) return new RequestCircularLoading();
                if (snapshot.data.isEmpty) return new Text("Assenza dati");

                return buildListCircle(snapshot.data);
            }
            return null; // unreachable
          },
        ),
      ),
    );
  }
}

class RequestCircularLoading extends StatelessWidget {
  const RequestCircularLoading({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: CircularProgressIndicator(
        strokeWidth: 3,
      ),
    );
  }
}
