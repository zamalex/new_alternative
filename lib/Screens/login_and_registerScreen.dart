import 'dart:developer';

import 'package:alternative_new/widgets/Login.dart';
import 'package:alternative_new/widgets/registerationWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginAndRegisterScreen extends StatefulWidget {
  const LoginAndRegisterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginAndRegisterScreen();
  }
}

class _LoginAndRegisterScreen extends State<LoginAndRegisterScreen> {

  bool isLogin = true;
  Widget currentForm = LoginWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: Color(0xFF009639)),
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/Logo.png',
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Container(
                    height: 615.12,
                    width: 342,
                    decoration: BoxDecoration(
                        color: Color(0xFFFEFEFE),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xFF009639)),
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFEFEFE),
                          ),
                          width: 275,
                          height: 40,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 37,
                                width: 125,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: isLogin ? Color(0xFF009639) : Color(0xFFFEFEFE),
                                ),
                                padding: EdgeInsets.only(right: 15, left: 15),
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                       currentForm = LoginWidget();
                                       isLogin = true;
                                      });
                                    },
                                    child: Text(
                                      '30'.tr,
                                      style: TextStyle(
                                        color: isLogin ? Color(0xFFFEFEFE) : Color(0xFF009639),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        backgroundColor: isLogin ? Color(0xFF009639) : Color(0xFFFEFEFE),
                                      ),
                                    )),
                              ),
                              Container(
                                height: 37,
                                width: 125,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: isLogin ? Color(0xFFFEFEFE) : Color(0xFF009639),
                                ),

                                padding: EdgeInsets.only(right: 15, left: 15),
                                child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        currentForm = RegisterationWidget();
                                        isLogin = false;
                                      });
                                    },
                                    child: Text(
                                      '31'.tr,
                                      style: TextStyle(
                                        color: isLogin ? Color(0xFF009639) : Color(0xFFFEFEFE),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        backgroundColor: isLogin ? Color(0xFFFEFEFE) : Color(0xFF009639),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        currentForm
                      ],
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
