import 'package:flutter/material.dart';

class CreationField extends StatelessWidget {
  final String chipTitle;
  final String hint;
  final Icon icon;
  final bool isPass;
  final Function onSaved;

  CreationField({
    @required this.chipTitle,
    @required this.isPass,
    @required this.hint,
    @required this.icon,
    @required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 6,
        ),
        Chip(
          label: Text(this.chipTitle),
        ),
        TextFormField(
          decoration: InputDecoration(
            filled: true,
            hintText: this.hint,
            hintStyle: TextStyle(
              color: Colors.white,
            ),
            fillColor: Colors.red,
            icon: this.icon,
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
            focusedBorder: UnderlineInputBorder(
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
          cursorColor: Colors.white,
          style: TextStyle(
            color: Colors.white,
          ),
          obscureText: this.isPass,
          onChanged: (newValue) {
            onSaved(newValue);
          },
        ),
      ],
    );
  }
}
