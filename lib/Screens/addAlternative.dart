import 'package:alternative_new/Screens/localProductOwnerAdd.dart';
import 'package:alternative_new/Screens/triedTheProductAddScreen.dart';
import 'package:alternative_new/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewAlternative extends StatefulWidget {
  const NewAlternative({super.key, required this.isBaycoot, required this.flag});

  final int isBaycoot;
  final int flag;
  @override
  State<NewAlternative> createState() {
    // TODO: implement createState
    return _NewAlternative();
  }
}

class _NewAlternative extends State<NewAlternative> {
  Color ColorProductOwner = Color(0xFF009639);
  Color ColortriedTheProduct = Color(0xFFFFFFFF);
  Image ProductOwnerImage = Image.asset(
    'assets/images/ProductOwner.png',
    color: Colors.white,
  );
  Image TriedtheProductImage = Image.asset(
    'assets/images/Triedtheproduct.png',
    color: Color(0xFF009639),
  );
  int ChoosenIndex = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Color(0xFF009639),
      ),
      body: Container(
        color: kPrimaryColor,
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Colors.white),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [

              SizedBox(
                height: 20,
              ),
              Text(
                "17".tr,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              Text(
                "18".tr,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 40,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      ChoosenIndex = 0;
                      ColorProductOwner = Color(0xFF009639);
                      ColortriedTheProduct = Color(0xFFFFFFFF);
                      ProductOwnerImage = Image.asset(
                        'assets/images/ProductOwner.png',
                        color: Color(0xFFFFFFFF),
                      );
                      TriedtheProductImage = Image.asset(
                        'assets/images/Triedtheproduct.png',
                        color: Color(0xFF009639),
                      );
                    });
                  },
                  child: Container(
                    width: 237,
                    height: 201,
                    decoration: BoxDecoration(
                        color: ColorProductOwner,
                        border: Border.all(color: ColortriedTheProduct),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ProductOwnerImage,
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "19".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: ColortriedTheProduct),
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      ChoosenIndex = 1;
                      ColorProductOwner = Color(0xFFFFFFFF);
                      ColortriedTheProduct = Color(0xFF009639);
                      ProductOwnerImage = Image.asset(
                        'assets/images/ProductOwner.png',
                        color: Color(0xFF009639),
                      );
                      TriedtheProductImage = Image.asset(
                        'assets/images/Triedtheproduct.png',
                        color: Color(0xFFFFFFFF),
                      );
                    });
                  },
                  child: Container(
                    width: 237,
                    height: 201,
                    decoration: BoxDecoration(
                        border: Border.all(color: ColorProductOwner),
                        color: ColortriedTheProduct,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TriedtheProductImage,
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "20".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                              color: ColorProductOwner),
                        )
                      ],
                    ),
                  )),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  if(ChoosenIndex == 0){
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => LocalProductOwnerAdd(isBaycoot: widget.isBaycoot, flag: widget.flag,)));
                  } else {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => TriedTheProductAdd(isBaycoot: widget.isBaycoot,flag: widget.flag,)));
                  }
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
                    Text("21".tr, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20,fontWeight: FontWeight.w600),),
                    SizedBox(width: 10,),
                    Icon(Icons.arrow_forward, color: Color(0xFFFFFFFF),),
                  ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
