import 'package:flutter/material.dart';

class RadioButton extends StatefulWidget{
   RadioButton({super.key,});

  @override
  State<RadioButton> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
class _RadioButton extends State<RadioButton>{
  var _groupValue = 1;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RadioMenuButton(
            value: 1,
            groupValue: _groupValue,
            onChanged: (value) {
              setState(() {
                _groupValue = value!;
              });
            },
            child: Text("individual"),
            style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(Color(0xFF009639)),
            )),
        // RadioListTile(value: 1, groupValue: 1, onChanged: (value){ },title: Text("Organization"),)
        RadioMenuButton(
          value: 2,
          groupValue: _groupValue,
          onChanged: (value) {
            setState(() {
              _groupValue = value!;
            });
          },
          child: Text("Organization"),
          style: ButtonStyle(
            foregroundColor:
            MaterialStateProperty.all<Color>(Color(0xFF009639)),
          ),
        )
      ],
    );
  }
}