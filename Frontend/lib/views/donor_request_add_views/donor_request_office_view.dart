import 'package:anavis/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorRequestOfficeView extends StatefulWidget {
  @override
  _DonorRequestOfficeViewState createState() => _DonorRequestOfficeViewState();
}

class _DonorRequestOfficeViewState extends State<DonorRequestOfficeView> {
  @override
  void initState() {
    super.initState();
  }

  List<DropdownMenuItem> createListItem() {
    List<DropdownMenuItem> listOfficeItem = new List<DropdownMenuItem>();
    for (var officeString in Provider.of<AppState>(context).getOfficeNames()) {
      listOfficeItem.add(
          new DropdownMenuItem(value: officeString, child: Text(officeString)));
    }
    return listOfficeItem;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: DropdownButtonFormField(
          onChanged: (_) {},
          items: createListItem(),
        ),
      ),
    );
  }
}
