import 'package:alternative_new/Data/dummyData.dart';
import 'package:alternative_new/Model/GridItemModel.dart';
import 'package:alternative_new/Screens/AccountScren.dart';
import 'package:alternative_new/widgets/gridItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PopularForiegnBrands extends StatefulWidget{
   PopularForiegnBrands({super.key, required this.ForiegnBrands});
  List<GridItemModel> ForiegnBrands;
  @override
  State<PopularForiegnBrands> createState() {
    // TODO: implement createState
    return _PopularForiegnBrands();
  }
}

class _PopularForiegnBrands extends State<PopularForiegnBrands>{
  int Stateindex = 0;
  String Searched = '';
  List<GridItemModel> allItemBaycoot = [];


  void SearchProduct(String Item) async{
    final url = Uri.parse('https://alternatifurunler.com/api/brands/search/${Item}');
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    List<GridItemModel> loadItem = [];
    for(final item in listData['data']) {
      loadItem.add(GridItemModel(isBaycoot: 0,
          image: item['brand_logo'],
          Details: item['brand_description'],
          Type: 'product',
          FoundYear: item['brand_year_founderd'] == null ? '' : item['brand_year_founderd'],
          Country: item['brand_origin_country']==null?'':item['brand_origin_country']['name'] == null ? '' : item['brand_origin_country']['name'],
          Name: item['brand_name'],
          id: item['id']));
    }
    setState(() {
      allItemBaycoot = loadItem;
    });
  }
  List<GridItemModel> AllItemBaycoot = [];
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Color(0xFF009639),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 155,
                decoration: BoxDecoration(
                    color: Color(0xFF009639),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12))),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/Logo.png',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 45,
                      child: Row(
                        children: [
                          SizedBox(width: 8,),
                          Expanded(
                            child: Container(
                              width: 35,
                              height: 65,
                              decoration: BoxDecoration(color: Colors.white,
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextFormField(
                                onChanged: (value){
                                  SearchProduct(value);
                                  Searched = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  ),
                                  hintText: '16'.tr,
                                  contentPadding: EdgeInsets.only(top: 2),
                                  hintStyle: TextStyle(

                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  ),
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 40,
                            height: 65,
                            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                            child: Image.asset('assets/images/scan.png'),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Container(
                            width: 40,
                            height: 65,
                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                            child: Image.asset('assets/images/camera.png'),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text("3".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              SizedBox(height: 20,),
              GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    childAspectRatio: 3 / 2,
                    mainAxisSpacing: 20,
                  ),
                  children: Searched.isEmpty ? List.generate(
                    widget.ForiegnBrands.length,
                        (index) => GridItem(Item: widget.ForiegnBrands[index]),
                  ) : allItemBaycoot.isNotEmpty ? List.generate(allItemBaycoot.length, (index) => GridItem(Item: allItemBaycoot[index])) : []),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '13'.tr,

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '14'.tr,
          ),
        ],
        onTap: (Stateindex) {
          if(Stateindex == 1){
            Navigator.push(context, MaterialPageRoute(builder: (ctx) => MyAccount()));
          }
        },
        currentIndex: Stateindex,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xFF009639),
      ),
    );
  }
}