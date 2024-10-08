import 'package:alternative_new/Model/GridItemModel.dart';
import 'package:alternative_new/main.dart';
import 'package:country_flags/country_flags.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_widgets.dart';

class ItemDetails extends StatefulWidget {
  ItemDetails({super.key, required this.Item});

  final GridItemModel Item;

  @override
  State<ItemDetails> createState() {
    // TODO: implement createState
    return _ItemDetails();
  }
}

class _ItemDetails extends State<ItemDetails> {
  var Stateindex = 0;

  @override
  Widget build(BuildContext context) {
    var smallImage;
    if (widget.Item.isBaycoot == true)
      smallImage = 'assets/images/false.png';
    else
      smallImage = 'assets/images/true.png';
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Color(0xFF009639),
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(widget.Item.Name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Color(0xFFFEFEFE)),),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: kPrimaryColor),
        padding: EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
              
             Card(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100),),elevation: 5,
               child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                                        widget.Item.image.toString(),
                                                        height: 150,
                                                        width: 150,
                                                      ),
                            )),
                        Image.asset(
                          smallImage,
                          width: 90,
                          height: 90,
                        ),
                      ],
                    ),
             ),

                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      "25".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      widget.Item.Details,
                      style: TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w400, height: 1),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Expanded(
                      child: Container(
                        width: 120,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.16),
                                blurRadius: 4,
                                spreadRadius: 0,
                                offset: Offset(0, 2),
                              ),
                            ]),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "26".tr,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400, fontSize: 14),
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  widget.Item.Type,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color(0xFF009639)),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  /*  Container(
                      width: 120,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.16),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(0, 2),
                            ),
                          ]),
                      child: Card(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "27".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 14),
                            ),
                            SizedBox(height: 5,),
                            Text(
                              widget.Item.FoundYear,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xFF009639)),
                            )
                          ],
                        ),
                      ),
                    ),*/

                    Expanded(child: Container(
                      width: 120,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.16),
                              blurRadius: 4,
                              spreadRadius: 0,
                              offset: Offset(0, 2),
                            ),
                          ]),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "28".tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 14),
                              ),
                              SizedBox(height: 5,),
                              SingleChildScrollView(
                                scrollDirection:Axis.horizontal ,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CountryFlag.fromCountryCode(countryToCode[widget.Item.Country]??'EG',width: 30,height: 20,),
                                    const SizedBox(width: 10,),
                                      Text(
                                      widget.Item.Country,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                          color: Color(0xFF009639)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )),
                  
                  ],
                ),
                SizedBox(height: 250,),
                Container(
                  width: 237,
                  height: 52,
                  child: ElevatedButton.icon(onPressed: () {}, label: Icon(Icons.arrow_forward_sharp,),icon:Text("24".tr,style: TextStyle(),) ,style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFF009639)), // Background color
                    foregroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFFEFEFE)), // Text and icon color
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10), // <-- Radius
                      ),
                    ),
        
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
