import 'package:alternative_new/Locale/locale_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ChangeLanguageScreen();
  }
}

class _ChangeLanguageScreen extends State<ChangeLanguageScreen> {
  var _groupvalue;
  MyLocaleController controller = Get.put(MyLocaleController());

  @override
    void initState() {
      if(controller.initialLang == "ar")
        _groupvalue = 1;
      if(controller.initialLang == "en")
        _groupvalue = 2;
      if(controller.initialLang == "tr")
        _groupvalue = 3;
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    MyLocaleController controllerLang = Get.find();
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "4".tr,
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        backgroundColor: Color(0xFF009639),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: kPrimaryColor),
        child: Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),

          child: Column(
            children: [

              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    controllerLang.ChangeLang("ar");
                    setState(() {
                      _groupvalue = 1;
                    });
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "العربية",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF009639)),
                          ),
                          Spacer(),
                          RadioMenuButton(
                              value: 1,
                              groupValue: _groupvalue,
                              onChanged: (value) {

                                setState(() {

                                  _groupvalue = value!;
                                });
                              },
                              child: Text('')),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    controllerLang.ChangeLang("en");

                    setState(() {
                      _groupvalue = 2;
                    });
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "ُEnglish",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF009639)),
                          ),
                          Spacer(),
                          RadioMenuButton(
                              value: 2,
                              groupValue: _groupvalue,
                              onChanged: (value) {
                                controllerLang.ChangeLang("en");
                                setState(() {
                                  _groupvalue = value!;
                                });
                              },
                              child: Text('')),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    controllerLang.ChangeLang("tr");
                    setState(() {
                      _groupvalue = 3;
                    });
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [

                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Türkçe",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF009639)),
                          ),
                          Spacer(),
                          RadioMenuButton(
                              value: 3,
                              groupValue: _groupvalue,
                              onChanged: (value) {
                                setState(() {
                                  _groupvalue = value!;
                                });
                              },
                              child: Text('')),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Container(),
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
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
                          Text("15".tr, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20,fontWeight: FontWeight.w600),),
                          SizedBox(width: 10,),
                          Icon(Icons.arrow_forward, color: Color(0xFFFFFFFF),),
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
