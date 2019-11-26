import 'package:anavis/model/app_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DonorCanDonateView extends StatefulWidget {
  @override
  _DonorCanDonateViewState createState() => _DonorCanDonateViewState();
}

class _DonorCanDonateViewState extends State<DonorCanDonateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<AppState>(context).getCanDonate()
          ? Colors.green
          : Colors.red,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
