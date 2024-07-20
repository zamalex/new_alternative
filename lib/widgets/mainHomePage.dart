// import 'dart:convert';
//
// import 'package:alternative_new/Data/dummyData.dart';
// import 'package:alternative_new/Model/GridItemModel.dart';
// import 'package:alternative_new/Screens/popularForiegnBrands.dart';
// import 'package:alternative_new/widgets/gridItem.dart';
// import 'package:alternative_new/Screens/popularLocalBrands.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
//
// class MainHomePage extends StatefulWidget{
//   const MainHomePage({super.key,});
//
//
//   @override
//   State<MainHomePage> createState() {
//     // TODO: implement createState
//     return _MainHomePage();
//   }
// }
//
//
// class _MainHomePage extends State<MainHomePage>{
//
//   late Future<List<GridItemModel>> loadedItems;
//   late Future<List<GridItemModel>> loadedItemsnotBaycoot;
//   @override
//   void initState() {
//     // TODO: implement initState
//   loadedItems = _loadItems();
//   loadedItemsnotBaycoot =  _loadItemsnotBaycoot();
//   }
//   List<GridItemModel> AllItem =[];
//   Future<List<GridItemModel>> _loadItems() async {
//     final url = Uri.parse('https://alternatifurunler.com/api/brands');
//     final response = await http.get(url);
//     final Map<String, dynamic> listdata = json.decode(response.body);
//     final List<GridItemModel> _loadedItems= [];
//
//
//     for(final item in listdata['data']){
//       _loadedItems.add(GridItemModel(isBaycoot: item['isAlternative'], image: item['brand_logo'], Details: item['brand_description'], Type: 'product', FoundYear: '1995', Country: item['brand_origin_country'] == null ? '' : item['brand_origin_country']['name'] ?? '', Name: item['brand_name']));
//     }
//     AllItem = _loadedItems;
//     return _loadedItems;
//   }
//
//   List<GridItemModel> AllItemnotbaycoot =[];
//   Future<List<GridItemModel>> _loadItemsnotBaycoot() async {
//     final url = Uri.parse('https://alternatifurunler.com/api/brandsAlternative');
//     final response = await http.get(url);
//     print(response.body);
//     final Map<String, dynamic> listdata1 = json.decode(response.body);
//     final List<GridItemModel> _loadedItems1= [];
//
//
//     for(final item in listdata1['data']){
//       _loadedItems1.add(GridItemModel(isBaycoot: 1, image: item['brand_logo'], Details: item['brand_description'] == null ? '' : item['brand_description'] ?? '', Type: 'product', FoundYear: '1995', Country: item['brand_origin_country'] == null ? '' : item['brand_origin_country']['name'] ?? '', Name: item['brand_name']));
//     }
//     AllItemnotbaycoot = _loadedItems1;
//     return _loadedItems1;
//   }
//
//   void _goToLocalBrands(){
//     Navigator.push(context, MaterialPageRoute(builder: (ctx) => PopularLocalBrands(localBrands: AllItemnotbaycoot,)));
//   }
//   void _goToForiegnBrands(){
//     Navigator.push(context, MaterialPageRoute(builder: (ctx) => PopularForiegnBrands(ForiegnBrands: AllItem,)));
//   }
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return FutureBuilder(future: loadedItems, builder: (context, snapshot) {
//       if(snapshot.connectionState == ConnectionState.waiting)
//         return Center(child: CircularProgressIndicator(),);
//         else if (snapshot.hasError)
//           return Center(child: Text(snapshot.error.toString()));
//
//     else if (snapshot.data!.isEmpty)
//       return Center(child: Text("No items added yet"));
//     else
//         return Column(
//           children: [
//             Row(
//               children: [
//                 Text(
//                   "Popular Local Brands",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Spacer(),
//                 InkWell(
//                   onTap: _goToLocalBrands,
//                   child: Row(
//                     children: [
//                       Text(
//                         "show more",
//                       ),
//                       Icon(Icons.arrow_forward)
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 15),
//               child: GridView(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 5,
//                     childAspectRatio: 3 / 2,
//                     mainAxisSpacing: 20,
//                   ),
//                   children: List.generate(
//                     6,
//                         (index) => GridItem(Item: AllItemnotbaycoot[index]),
//                   )),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Row(
//               children: [
//                 Text(
//                   "Popular Foriegn Brands",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 20,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Spacer(),
//                 InkWell(
//                   onTap: _goToForiegnBrands,
//                   child: Row(
//                     children: [
//                       Text(
//                         "show more",
//                       ),
//                       Icon(Icons.arrow_forward)
//                     ],
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(right: 15),
//               child: GridView(
//                   physics: NeverScrollableScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3,
//                     crossAxisSpacing: 5,
//                     childAspectRatio: 3 / 2,
//                     mainAxisSpacing: 20,
//                   ),
//                   children: List.generate(
//                     6,
//                         (index) => GridItem(Item: AllItem[index]),
//                   )),
//             ),
//           ],
//         );
//     });
//   }
// }