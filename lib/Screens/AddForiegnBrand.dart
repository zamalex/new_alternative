import 'package:alternative_new/Data/dummyData.dart';
import 'package:alternative_new/Model/GridItemModel.dart';
import 'package:alternative_new/Screens/addAlternative.dart';
import 'package:alternative_new/widgets/gridItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AddForiegnBrands extends StatefulWidget{
  const AddForiegnBrands({super.key});

  @override
  State<AddForiegnBrands> createState() {
    // TODO: implement createState
    return _AddForiegnBrands();
  }
}

class _AddForiegnBrands extends State<AddForiegnBrands>{
  late Future<List<GridItemModel>> loadedItems;
  void initState() {
    // TODO: implement initState
    loadedItems = _loadItems();
  }

  @override
  List<GridItemModel> AllItem =[];
  Future<List<GridItemModel>> _loadItems() async {
    final url = Uri.parse('https://alternatifurunler.com/api/brands');
    final response = await http.get(url);
    final Map<String, dynamic> listdata = json.decode(response.body);
    final List<GridItemModel> _loadedItems= [];


    for(final item in listdata['data']){
      _loadedItems.add(GridItemModel(isBaycoot: item['isAlternative'], image: item['brand_logo'], Details: item['brand_description'], Type: 'product', FoundYear: '1995', Country: item['brand_origin_country'] == null ? '' : item['brand_origin_country']['name'] ?? '', Name: item['brand_name'], id: item['id']));
    }
    AllItem = _loadedItems;
    return _loadedItems;
  }

  int Stateindex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "8".tr,
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
        child: FutureBuilder(future: loadedItems, builder: (context, snapshot){
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
                              AllItem.length,
                                  (index) => GridItem(Item: AllItem[index]),
                            )),
                        SizedBox(height: 150,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 5,),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (ctx) => NewAlternative(isBaycoot: 1, flag: 0,)));
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
                          Text("8".tr, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20,fontWeight: FontWeight.w600),),
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