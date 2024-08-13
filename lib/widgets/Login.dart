import 'dart:ffi';
import 'dart:convert';

import 'package:alternative_new/Locale/locale_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:alternative_new/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _loginWidget();
  }
}
bool obscureText1 = true;
class _loginWidget extends State<LoginWidget> {
  SharedprefServices sharedprefServices = SharedprefServices();

  Widget ErrorMessage = AlertDialog(
    title: Text("error"),
    content: Text("invalid Email or Password"),
  );

  final _formkey = GlobalKey<FormState>();

  void LoginButton() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final url = Uri.parse("https://alternatifurunler.com/api/loginAPI");
      final response = await http.post(url,
          headers: {'content-type': 'application/json'},
          body: json.encode({
            'email': _enteredEmail,
            'password': _enteredPassword,
          }));
      print(response.statusCode);
      print(response.body);
      final userResponse = json.decode(response.body);
      final token = userResponse['token'];
      sharedprefServices.writeCache(key: 'email', value: _enteredEmail!);
      sharedprefServices.writeCache(key: 'password', value: _enteredPassword!);
      sharedprefServices.writeCache(key: 'name', value: userResponse['user']['name']);
      sharedprefServices.writeCache(key: 'image', value: userResponse['user']['image']);
      sharedprefServices.writeCache(key: 'token', value: token);

      if (response.statusCode == 200) {
        isSaved = true;
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => HomePage()));
        sharedprefServices.writeCache(key: 'email', value: _enteredEmail!);
        sharedprefServices.writeCache(key: 'password', value: _enteredPassword!);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("invalid Email or Password"),
          duration: Duration(seconds: 3),
        ));
      }
    }
  }

  String? _enteredEmail;
  String? _enteredPassword;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Container(
      child: Expanded(
        child: Column(
          children: [
            Text(
              "32".tr,
              style: TextStyle(
                  color: Color(0xFF121212),
                  fontWeight: FontWeight.w600,
                  fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            Form(
              key: _formkey,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(children: [
                  Container(
                    height: 60,
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
                          prefixIcon: Icon(Icons.mail,
                              color: Color.fromRGBO(217, 217, 217, 20)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: '39'.tr,
                          hintStyle: TextStyle(
                              color: Color.fromRGBO(217, 217, 217, 20))),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 60,
                    child: TextFormField(
                      obscureText: obscureText1,
                      onSaved: (value) {
                        _enteredPassword = value!;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 6 ||
                            value.length < 1)
                          return "49".tr;
                        return null;
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
                  )
                ]),
              ),
            ),
            // Row(
            //   children: [
            //     Spacer(),
            //     InkWell(
            //       child: Text(
            //         "Forgot Password ?",
            //         style: TextStyle(
            //             color: Color(0xFF009639),
            //             fontWeight: FontWeight.w600,
            //             fontSize: 12,
            //             decoration: TextDecoration.underline,
            //             decorationColor: Color(0xFF009639)),
            //       ),
            //     ),
            //     SizedBox(
            //       width: 20,
            //     )
            //   ],
            // ),
            Spacer(),
            Container(
              height: 52,
              width: 201,
              child: ElevatedButton.icon(
                onPressed: () {
                  LoginButton();
                },
                label: Icon(
                  Icons.arrow_forward_sharp,
                  color: Color(0xFFFEFEFE),
                ),
                icon: Text(
                  "30".tr,
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
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
