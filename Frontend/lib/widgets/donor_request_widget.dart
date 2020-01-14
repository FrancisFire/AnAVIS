import 'package:anavis/widgets/painter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildDonorRequestWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String labelDropDown;
  final Icon icon;
  final String valueSelected;
  final List<DropdownMenuItem> fetchItems;
  final Function onChanged;

  BuildDonorRequestWidget({
    @required this.title,
    @required this.subtitle,
    @required this.icon,
    @required this.labelDropDown,
    @required this.valueSelected,
    @required this.fetchItems,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: CustomPaint(
          painter: Painter(
            first: Colors.red[100],
            second: Colors.orange[200],
            background: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AutoSizeText(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 64,
                  ),
                  maxLines: 1,
                ),
                AutoSizeText(
                  subtitle,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 32,
                  ),
                  maxLines: 3,
                ),
                SizedBox(
                  height: 24.0,
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Colors.red,
                  ),
                  child: ButtonTheme(
                    child: DropdownButtonFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.red,
                        icon: icon,
                        enabledBorder: UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              24.0,
                            ),
                          ),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      hint: Text(
                        labelDropDown,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      iconEnabledColor: Colors.white,
                      elevation: 18,
                      items: fetchItems,
                      value: valueSelected,
                      onChanged: (newValue) {
                        onChanged(newValue);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
