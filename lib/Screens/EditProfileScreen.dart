import 'package:alternative_new/widgets/EditIndividualProfile.dart';
import 'package:alternative_new/widgets/EditOrganizationProfile.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../main.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() {
    // TODO: implement createState
    return _EditProfile();
  }
}

class _EditProfile extends State<EditProfile> {
  final _formkey = GlobalKey<FormState>();

  String? _enteredname;
  String? _enteredNumber;
  String? _enteredemail;
  String? token;
  void initial() async{
    final SharedprefServices pref = new SharedprefServices();
    token = await pref.readCache(key: "token");
    print(token);
  }


  @override
  void initState() {
    // TODO: implement initState
    initial();
  }


  void _editProfile() async {
    if (_formkey.currentState!.validate()) {
      _formkey.currentState!.save();
      final url = Uri.parse('https://alternatifurunler.com/api/updateProfile',
      );
      final response = await http.put(url,
          headers: {'content-type': 'application/json',
            'Authorization' : 'Bearer ' + token!,},
          body: json.encode(
              {
                'name': _enteredname,
                'email': _enteredemail,
              }));
      print({"Accept": "application/json",
        'Authorization' : 'Bearer ' + token!,});
      if(response.statusCode == 200 || response.statusCode == 201) {
        final SharedprefServices pref = new SharedprefServices();
        pref.writeCache(key: 'name', value: _enteredname!);
        pref.writeCache(key: 'email', value: _enteredemail!);
      }
      print(response.statusCode);
      Navigator.of(context).pop();
    }
  }

    Widget _ActiveScreen = EditIndividualProfile();
    var _groupValue = 1;

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          title: Text(
            "6".tr,
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w600,
                fontSize: 22),
          ),
          backgroundColor: Color(0xFF009639),
          centerTitle: true,
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: kPrimaryColor),
          child: Container(
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),

            child: SingleChildScrollView(
              child: Column(
                children: [

                  SizedBox(height: 40,),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              Container(
                                height: 44,
                                child: TextFormField(
                                  onSaved: (value) {
                                    _enteredname = value!;
                                  },
                                  validator: (value) {
                                    if( value == null || value.isEmpty || value.length < 2)
                                      return "44".tr;
                                    return null;
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
                                height: 44,
                                child: TextFormField(
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
                                height: 44,
                                child: TextFormField(
                                  onSaved: (value) {
                                    _enteredemail = value!;
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
                              // Container(
                              //   height: 44,
                              //   child: TextFormField(
                              //     decoration: InputDecoration(
                              //         prefixIcon: Icon(
                              //           Icons.lock,
                              //           color: Color.fromRGBO(217, 217, 217, 20),
                              //         ),
                              //         suffixIcon: Icon(
                              //           Icons.visibility_off,
                              //           color: Color.fromRGBO(217, 217, 217, 20),
                              //         ),
                              //         border: OutlineInputBorder(
                              //             borderRadius: BorderRadius.circular(10)),
                              //         hintText: 'Password',
                              //         hintStyle: TextStyle(
                              //           color: Color.fromRGBO(217, 217, 217, 20),
                              //         )),
                              //   ),
                              // ),

                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(right: 20, left: 20),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       RadioMenuButton(
                      //           value: 1,
                      //           groupValue: _groupValue,
                      //           onChanged: (value) {
                      //             setState(() {
                      //               _groupValue = value!;
                      //               _ActiveScreen = EditIndividualProfile();
                      //             });
                      //           },
                      //           child: Text("individual"),
                      //           style: ButtonStyle(
                      //             foregroundColor:
                      //             MaterialStateProperty.all<Color>(Color(0xFF009639)),
                      //           )),
                      //       // RadioListTile(value: 1, groupValue: 1, onChanged: (value){ },title: Text("Organization"),)
                      //       RadioMenuButton(
                      //         value: 2,
                      //         groupValue: _groupValue,
                      //         onChanged: (value) {
                      //           setState(() {
                      //             _groupValue = value!;
                      //             _ActiveScreen = EditOrganizationProfile();
                      //           });
                      //         },
                      //         child: Text("Organization"),
                      //         style: ButtonStyle(
                      //           foregroundColor:
                      //           MaterialStateProperty.all<Color>(Color(0xFF009639)),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      SizedBox(height: 250,),
                      InkWell(
                        onTap: () {
                          _editProfile();
                        },
                        child: Container(
                          width: 237,
                          height: 52,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF009639)
                          ),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("15".tr, style: TextStyle(color: Color(
                                    0xFFFFFFFF),
                                    fontSize: 20,
                                    fontWeight: FontWeight
                                        .w600),),
                                SizedBox(width: 10,),
                                Icon(Icons.arrow_forward, color: Color(
                                    0xFFFFFFFF),),
                              ]),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }