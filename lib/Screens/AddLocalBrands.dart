import 'package:alternative_new/Data/dummyData.dart';
import 'package:alternative_new/Model/GridItemModel.dart';
import 'package:alternative_new/Screens/addAlternative.dart';
import 'package:alternative_new/widgets/gridItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddLocalBrands extends StatefulWidget{
  const AddLocalBrands({super.key});

  @override
  State<AddLocalBrands> createState() {
    // TODO: implement createState
    return _AddLocalBrands();
  }
}

class _AddLocalBrands extends State<AddLocalBrands>{

  int Stateindex = 0;

  late Future<List<GridItemModel>> loadedItemsnotBaycoot;
  List<GridItemModel> AllItemnotbaycoot =[];
  Future<List<GridItemModel>> _loadItemsnotBaycoot() async {
    final url = Uri.parse('https://alternatifurunler.com/api/brandsAlternative');
    final response = await http.get(url);
    print(response.body);
    final Map<String, dynamic> listdata1 = json.decode(response.body);
    final List<GridItemModel> _loadedItems1= [];


    for(final item in listdata1['data']){
      _loadedItems1.add(GridItemModel(isBaycoot: 1, image: item['brand_logo'], Details: item['brand_description'] == null ? '' : item['brand_description'] ?? '', Type: 'product', FoundYear: '1995', Country: item['brand_origin_country'] == null ? '' : item['brand_origin_country']['name'] ?? '', Name: item['brand_name'], id: item['id']));
    }
    AllItemnotbaycoot = _loadedItems1;
    return _loadedItems1;
  }


  @override
  void initState() {
    // TODO: implement initState
    loadedItemsnotBaycoot = _loadItemsnotBaycoot();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "7".tr,
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        backgroundColor: Color(0xFF009639),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
          child: FutureBuilder(future: loadedItemsnotBaycoot, builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(),);
            else if (snapshot.hasError)
              return Center(child: Text(snapshot.error.toString()));

            else if (snapshot.data!.isEmpty)
              return Center(child: Text("No items added yet"));
            else
              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child:
                        Column(
                          children: [
                            Container(
                              height: 20,
                              decoration: BoxDecoration(
                                  color: Color(0xFF009639),
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(12))),
                            ),
                            SizedBox(height: 40,),
                            GridView(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  crossAxisSpacing: 5,
                                  childAspectRatio: 1,
                                  mainAxisSpacing: 20,
                                ),
                                children: List.generate(
                                  AllItemnotbaycoot.length,
                                      (index) => GridItem(Item: AllItemnotbaycoot[index]),
                                )),
                            SizedBox(height: 150,),
                          ],
                        ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (ctx) => NewAlternative(isBaycoot: 0, flag: 0,)));
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
                            Text("7".tr, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20,fontWeight: FontWeight.w600),),
                            SizedBox(width: 10,),
                            Icon(Icons.arrow_forward, color: Color(0xFFFFFFFF),),
                          ]),
                    ),
                  ),
                  SizedBox(height: 30,)
                ],
              );
          }),
        ),
    );
  }
}