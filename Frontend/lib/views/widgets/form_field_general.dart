import 'package:flutter/material.dart';

class FormFieldGeneral extends StatelessWidget {
  final Icon icon;
  final String labelDropDown;
  final List<DropdownMenuItem<dynamic>> fetchItems;
  final String valueSelected;
  final Function onChanged;

  FormFieldGeneral({
    @required this.icon,
    @required this.labelDropDown,
    @required this.fetchItems,
    @required this.valueSelected,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.red,
      ),
      child: ButtonTheme(
        child: DropdownButtonFormField(
            isExpanded: true,
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
            }),
      ),
    );
  }
}
