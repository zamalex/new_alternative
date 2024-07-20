import 'package:alternative_new/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLocaleController extends GetxController{
  Locale? initialLang = Get.deviceLocale;
  void ChangeLang(String codelang) async{
    Locale locale = Locale(codelang);
     final SharedPreferences sharedprefServices = await SharedPreferences.getInstance();
    sharedprefServices.setString("lang", codelang);
    Get.updateLocale(locale);
  }
}