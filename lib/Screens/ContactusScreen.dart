import 'package:flutter/material.dart';
import 'package:get/get.dart';
class Contactus extends StatefulWidget {
  const Contactus({super.key});

  @override
  State<Contactus> createState() {
    // TODO: implement createState
    return _Contactus();
  }
}

class _Contactus extends State<Contactus> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          title: Text(
            "10".tr,
            style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.w600,
                fontSize: 22),
          ),
          backgroundColor: Color(0xFF009639),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                  color: Color(0xFF009639),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      bottomLeft: Radius.circular(12))),
            ),
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text("to: alternatifurunler@b1rincitech.com", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xFF009639)),),
            ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    height: 540,
                    child: TextFormField(
                      maxLines: 20,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.mail,
                            color: Color.fromRGBO(217, 217, 217, 20),
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: '54'.tr,
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(217, 217, 217, 20),
                          )),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Container(
                      width: 237,
                      height: 52,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF009639)
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("55".tr, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20,fontWeight: FontWeight.w600),),
                            SizedBox(width: 10,),
                            Icon(Icons.arrow_forward, color: Color(0xFFFFFFFF),),
                          ]),
                    ),
                  ),
                )
          ]),
        ));
  }
}
