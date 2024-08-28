import 'package:alternative_new/Data/dummyData.dart';
import 'package:alternative_new/Screens/AccountScren.dart';
import 'package:alternative_new/main.dart';
import 'package:alternative_new/widgets/gridItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:alternative_new/Model/GridItemModel.dart';

import '../widgets/custom_widgets.dart';


class PopularLocalBrands extends StatefulWidget{
   PopularLocalBrands({super.key, required this.localBrands});

  List<GridItemModel> localBrands;

  @override
  State<PopularLocalBrands> createState() {
    // TODO: implement createState
    return _PopularLocalBrands();
  }
}

class _PopularLocalBrands extends State<PopularLocalBrands>{
  List<GridItemModel> AllItemNotBaycoot =[];
  bool isSearching = false;
  late Future<List<GridItemModel>> LoadItem;
    String itemSearch = '';

  void SearchProduct(String Item) async {
      final url = Uri.parse('https://alternatifurunler.com/api/brandsAlternative/search/${Item}/location_id={$CountryId}');

      final response = await http.get(url);
      final Map<String, dynamic> listdata = json.decode(response.body);
       print(response.body);
      final List<GridItemModel> _loadedItems1 = [];
      for(final item in listdata['data']){
        _loadedItems1.add(GridItemModel(isBaycoot: 1, image: item['brand_logo'], Details: item['brand_description'] == null ? '' : item['brand_description'] ?? '', Type: 'product', FoundYear: '1995', Country: item['brand_origin_country'] == null ? '' : item['brand_origin_country']['name'] ?? '', Name: item['brand_name'],  id: item['id']));
      }
      setState(() {
            AllItemNotBaycoot = _loadedItems1;
      });
  }

  Future<List<GridItemModel>> _loadItemsnotBaycoot() async {
    final url = Uri.parse('https://alternatifurunler.com/api/brandsAlternative?location_id=$CountryId');
    final response = await http.get(url);
    print(CountryId);
    print(response.body);
    final Map<String, dynamic> listdata1 = json.decode(response.body);
    final List<GridItemModel> _loadedItems1= [];


    for(final item in listdata1['data']){
      _loadedItems1.add(GridItemModel(isBaycoot: 1, image: item['brand_logo'], Details: item['brand_description'] == null ? '' : item['brand_description'] ?? '', Type: 'product', FoundYear: '1995', Country: item['brand_origin_country'] == null ? '' : item['brand_origin_country']['name'] ?? '', Name: item['brand_name'], id: item['id']));
    }
    widget.localBrands = _loadedItems1;

    setState(() {

    });
    return _loadedItems1;
  }

  int Stateindex = 0;
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
                                onChanged: (value) {
                                  SearchProduct(value);
                                  itemSearch = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Row(
                                    children: [
                                      SizedBox(width: 10,),
                                      Container(
                                          height: 20,
                                          width: 50,
                                          child: CountryDropdown(selectedCountryId: CountryId??0,onSelect: (){
                                            _loadItemsnotBaycoot();
                                          },)),
                                      Icon(
                                        Icons.search,
                                        color: Color.fromRGBO(217, 217, 217, 20),
                                      ),
                                    ],
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
              Text("1".tr, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),),
              SizedBox(height: 20,),
              GridView(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1.3,
                    mainAxisSpacing: 20,
                  ),
                  children: itemSearch.isEmpty ? List.generate(
                    widget.localBrands.length,
                        (index) => GridItem(Item: widget.localBrands[index]),
                  ) : AllItemNotBaycoot.isNotEmpty ? List.generate(AllItemNotBaycoot.length, (index) => GridItem(Item: AllItemNotBaycoot[index]),) : []),
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