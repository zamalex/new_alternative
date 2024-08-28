import 'dart:convert';

import 'package:alternative_new/Screens/home_page.dart';
import 'package:alternative_new/Screens/login_and_registerScreen.dart';
import 'package:alternative_new/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/country.dart';
import 'package:http/http.dart' as http;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<List<Country>> fetchCountries() async {
    try {
      final response = await http
          .get(Uri.parse('https://alternatifurunler.com/api/countries'));

      if (response.statusCode == 200) {
        // Parse the JSON data
        final List<dynamic> jsonResponse = json.decode(response.body)['data'];
        // Map JSON to list of Country objects
        return jsonResponse.map((json) => Country.fromJson(json)).toList();
      } else {
        // Handle error response
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  bool loaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   fetchCountries().then((value) {
     setState(() {
       countries = value;
       print('countries length ${countries.length}');
       loaded = true;

       getMyCountry();
     });
   },);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/logo1.png'),
              if(loaded)
              Positioned(
                bottom: 50,
                child: Column(
                  children: [
                    if(!isSaved)
                      TextButton.icon(
                        style: ButtonStyle(backgroundColor: WidgetStateProperty.all(kPrimaryColor,),padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20,vertical: 10)),shape: WidgetStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))),
                          label: Icon(Icons.arrow_forward,color: Colors.white,),
                          onPressed: () {
                            Get.to(LoginAndRegisterScreen());
                          },
                          icon: Text(
                            'Lets\' start',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          )),

                    TextButton(
                        onPressed: () {
                          Get.to(HomePage());
                        },
                        child: Text(
                          isSaved?'Continue':'Continue as guest',
                          style: TextStyle(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        )),

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
