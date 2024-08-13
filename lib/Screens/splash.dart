import 'package:alternative_new/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

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
              Positioned(

                bottom: 50,
                child: TextButton(
                    onPressed: () {
                      Get.to(HomePage());
                    },
                    child: Text('Skip',style: TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 30),)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
