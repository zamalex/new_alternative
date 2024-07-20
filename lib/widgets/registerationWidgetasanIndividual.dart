import 'package:alternative_new/Screens/home_page.dart';
import 'package:alternative_new/widgets/radioButtons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterationasanIndividual extends StatefulWidget {
  const RegisterationasanIndividual({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RegisterationasanIndividual();
  }
}
bool obscureText1 = true;

class _RegisterationasanIndividual extends State<RegisterationasanIndividual> {
  var _formkey = GlobalKey<FormState>();
  var _enteredName;
  var _enteredPhoneNumber;
  var _enteredEmail;
  var _enteredPassword;
  var _enteredConfirm;

  void RegisterButton() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      
      if( _enteredPassword != _enteredConfirm) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("The Password must Match")));
        return;
      }
      final url = Uri.parse('https://alternatifurunler.com/api/registerAPI');
      final response = await http.post(url,
          headers: {'content-type': 'application/json'},
          body: json.encode({
            'name': _enteredName,
            'email': _enteredEmail,
            'password': _enteredPassword.toString(),
          }));
      if (response.statusCode == 200 || response.statusCode == 201 ) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => HomePage()));
      } else {
        print(response.statusCode);
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Something went wrong , please try again later"),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formkey,
      child: Column(
        children: [
          Container(
            height: 50,
            child: TextFormField(
              onSaved: (value) {
                _enteredName = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 1)
                  return '44'.tr;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color.fromRGBO(217, 217, 217, 20),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: '37'.tr,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(217, 217, 217, 20),
                  )),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 50,
            child: TextFormField(
              onSaved: (value) {
                _enteredPhoneNumber = value;
              },
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.length < 1 ||
                    value.length > 11)
                  return '46'.tr;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_android_sharp,
                    color: Color.fromRGBO(217, 217, 217, 20),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: '38'.tr,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(217, 217, 217, 20),
                  )),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 50,
            child: TextFormField(
              onSaved: (value) {
                _enteredEmail = value!;
              },
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    value.contains('@') == false)
                  return "48".tr;
                return null;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Color.fromRGBO(217, 217, 217, 20),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: '39'.tr,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(217, 217, 217, 20),
                  )),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 50,
            child: TextFormField(
              obscureText: obscureText1,
              onSaved: (value) {
                _enteredPassword = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 1)
                  return '47'.tr;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color.fromRGBO(217, 217, 217, 20),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        if(obscureText1 == true)
                          obscureText1 = false;
                        else
                          obscureText1 = true;

                      });
                    },
                    child: obscureText1 ? Icon(Icons.visibility_off,
                        color: Color.fromRGBO(217, 217, 217, 20)) :Icon(Icons.visibility,
                        color: Color.fromRGBO(217, 217, 217, 20)) ,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: '40'.tr,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(217, 217, 217, 20),
                  )),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 50,
            child: TextFormField(
              obscureText: obscureText1,
              onSaved: (value) {
                _enteredConfirm = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty || value.length < 1)
                  return '47'.tr;
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color.fromRGBO(217, 217, 217, 20),
                  ),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        if(obscureText1 == true)
                          obscureText1 = false;
                        else
                          obscureText1 = true;

                      });
                    },
                    child: obscureText1 ? Icon(Icons.visibility_off,
                        color: Color.fromRGBO(217, 217, 217, 20)) :Icon(Icons.visibility,
                        color: Color.fromRGBO(217, 217, 217, 20)) ,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: '41'.tr,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(217, 217, 217, 20),
                  )),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          Container(
            height: 50,
            width: 201,
            child: ElevatedButton.icon(
              onPressed: () {
                RegisterButton();
              },
              label: Icon(
                Icons.arrow_forward_sharp,
                color: Color(0xFFFEFEFE),
              ),
              icon: Text(
                "31".tr,
                style: TextStyle(
                  color: Color(0xFFFEFEFE),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFF009639)), // Background color
                foregroundColor: MaterialStateProperty.all<Color>(
                    Color(0xFFFEFEFE)), // Text and icon color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // <-- Radius
                  ),
                ),
              ),
            ),
          ),
          // RadioButtons(signupScreen: ,),
        ],
      ),
    );
  }
}
