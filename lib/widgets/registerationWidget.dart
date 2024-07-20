import 'package:alternative_new/widgets/registerationWidgetasanIndividual.dart';
import 'package:alternative_new/widgets/registerationWidgetasanOrganizaion.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterationWidget extends StatefulWidget {
  const RegisterationWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterationWidget();
  }
}

void setScreen(_groupValue, _signupScreen){
  if (_groupValue == 1){
    Widget _signupScreen = RegisterationasanIndividual();
  } else if (_groupValue == 2){
    Widget _signupScreen = RegisterationasanOrganization();
  }
}

class _RegisterationWidget extends State<RegisterationWidget> {
  Widget _signupScreen = RegisterationasanIndividual();
  var _groupValue = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(
          "35".tr,
          style: TextStyle(
              color: Color(0xFF121212),
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              _signupScreen,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RadioMenuButton(
                      value: 1,
                      groupValue: _groupValue,
                      onChanged: (value) {
                        setState(() {
                          _groupValue = value!;
                          _signupScreen = RegisterationasanIndividual();
                        });
                      },
                      child: Text("33".tr),
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
                        _signupScreen = RegisterationasanOrganization();
                      });
                    },
                    child: Text("34".tr),
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Color(0xFF009639)),
                    ),
                  )
                ],
              ),

            ],
          ),
        )
      ],
    );
  }
}
