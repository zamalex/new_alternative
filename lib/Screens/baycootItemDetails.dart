import 'package:alternative_new/Data/dummyData.dart';
import 'package:alternative_new/Model/GridItemModel.dart';
import 'package:alternative_new/Screens/addAlternative.dart';
import 'package:alternative_new/main.dart';
import 'package:alternative_new/widgets/gridItem.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:translator/translator.dart';
import 'dart:convert';

import '../widgets/custom_widgets.dart';

class BaycootItemDetails extends StatefulWidget {
  BaycootItemDetails({super.key, required this.Item});

  final GridItemModel Item;

  @override
  State<BaycootItemDetails> createState() {
    // TODO: implement createState
    return _BaycootItemDetails();
  }
}

class _BaycootItemDetails extends State<BaycootItemDetails> {
  List<GridItemModel> AllItemBaycoot = [];
  @override
  void start() async {
    final url = Uri.parse('https://alternatifurunler.com/api/brands/search/${widget.Item.Name}');
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    List<GridItemModel> loadItem = [];
    for(final item in listData['data'][0]['brandAlternatives']) {
      loadItem.add(GridItemModel(isBaycoot: 1,
          image: item['brand_logo'],
          Details: item['brand_additional_notes'] == null ? '' : item['brand_additional_notes'],
          Type: 'product',
          FoundYear: item['brand_year_founderd'] == null ? '' : item['brand_year_founderd'].toString(),
          Country: item['brand_origin_country']==null?'':item['brand_origin_country']['name'] == null ? '' : item['brand_origin_country']['name'],
          Name: item['brand_name'],
          id: item['id']));
      AllItemBaycoot = loadItem;
    }
    setState(() {
      AllItemBaycoot = loadItem;
    });
  }
  final translator = GoogleTranslator();

  void initState() {

    // TODO: implement initState
   start();

   widget.Item.Details.translate(to: Get.locale!.languageCode).then((value) {
     setState(() {
       widget.Item.Details = value.text;
     });
   },);
  }
  @override
  var Stateindex = 0;

  @override
  Widget build(BuildContext context) {
    var smallImage;
      smallImage = 'assets/images/false.png';

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text(widget.Item.Name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Color(0xFFFEFEFE)),),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(color: kPrimaryColor,),
        padding: EdgeInsets.all(16),
        width: double.infinity,
        height: double.infinity,
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
            
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius:  BorderRadius.circular(100)),
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
                   /* Expanded(
                      child: Container(
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
                      ),
                    ),*/

                    Expanded(
                      child: Container(
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
                                  scrollDirection: Axis.horizontal,
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
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(width: 20,),
                    Text("29".tr, style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),)
                  ],
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: GridView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 5,
                        childAspectRatio: 1,
                        mainAxisSpacing: 20,
                      ),
                      children: List.generate(
                        AllItemBaycoot.length ,
                            (index) => GridItem(Item: AllItemBaycoot[index]),
                      )),
                ),
                SizedBox(height: 75,),
                Container(
                  width: 237,
                  height: 52,
                  child: ElevatedButton.icon(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => NewAlternative(isBaycoot: 0, flag: widget.Item.id,)));
                  }, label: Icon(Icons.arrow_forward_sharp,),icon:Text("24".tr,style: TextStyle(),) ,style: ButtonStyle(
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
