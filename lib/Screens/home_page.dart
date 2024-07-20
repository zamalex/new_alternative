import 'dart:developer';
import 'dart:ui';
import 'package:alternative_new/main.dart';
import 'dart:convert';
import 'package:alternative_new/Locale/locale_controller.dart';
import 'package:country_ip/country_ip.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:alternative_new/Screens/baycootItemDetails.dart';
import 'package:alternative_new/Screens/itemDetailsScreen.dart';
import 'package:alternative_new/Screens/popularForiegnBrands.dart';
import 'package:flutter/services.dart';
import 'package:alternative_new/main.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart'as http;
import 'package:alternative_new/Data/dummyData.dart';
import 'package:alternative_new/Model/GridItemModel.dart';
import 'package:alternative_new/Screens/AccountScren.dart';
import 'package:alternative_new/widgets/gridItem.dart';
import 'package:alternative_new/widgets/mainHomePage.dart';
import 'package:alternative_new/Screens/popularLocalBrands.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}



class _HomePage extends State<HomePage> {
  int Stateindex = 0;
  int CurrentScreenState = 0;
  List<GridItemModel> AllItemNotBaycoot = [];
  List<GridItemModel> AllItemBaycoot = [];
  String Searched = '';
  // Widget _currentScreen = MainHomePage();

  late Future<List<GridItemModel>> loadedItems;
  late Future<List<GridItemModel>> loadedItemsnotBaycoot;
  @override
  void initState() {
    // TODO: implement initState
    loadedItems = _loadItems();
    loadedItemsnotBaycoot =  _loadItemsnotBaycoot();
  }
String? _scanBarcodeResult;
  void openCamera() async {
    WidgetsFlutterBinding.ensureInitialized();
    String _barcodeReader;
    try {
      _barcodeReader = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'cancel',
        false,
        ScanMode.BARCODE,
      );
    } on PlatformException {
      _barcodeReader = '';

    }
    if (!mounted) return;
    setState(() async{
       _scanBarcodeResult = _barcodeReader;
       final url =  Uri.parse('https://alternatifurunler.com/api/brands/search/$_scanBarcodeResult');
       final response = await http.get(url);
       final Map<String, dynamic> listdata = json.decode(response.body);
       final List<GridItemModel> loadeditem = [];
       if(listdata.isEmpty){
         final url =  Uri.parse('https://alternatifurunler.com/api/brandsAlternative/search/$_scanBarcodeResult');
         final response = await http.get(url);
         final Map<String, dynamic> listdata = json.decode(response.body);
         for(final item in listdata['data']){
           loadeditem.add(GridItemModel(isBaycoot: 0,
               image: item['brand_logo'],
               Details: item['brand_description'],
               Type: 'product',
               FoundYear: item['brand_year_founderd'] == null ? '' : item['brand_year_founderd'],
               Country: item['brand_origin_country']['name'] == null ? '' : item['brand_origin_country']['name'],
               Name: item['brand_name'],
               id: item['id']));
         }
         Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => ItemDetails(Item: loadeditem[0])));
         return;
       }
       for(final item in listdata['data']){
         loadeditem.add(GridItemModel(isBaycoot: 0,
             image: item['brand_logo'],
             Details: item['brand_description'],
             Type: 'product',
             FoundYear: item['brand_year_founderd'] == null ? '' : item['brand_year_founderd'],
             Country: item['brand_origin_country']['name'] == null ? '' : item['brand_origin_country']['name'],
             Name: item['brand_name'],
             id: item['id']));
       }
       Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => BaycootItemDetails(Item: loadeditem[0])));
       return;
    });
  }



  // void openCamera() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   String _barcodeReader;
  //   FlutterBarcodeScanner.getBarcodeStreamReceiver(
  //     '#ff6666',
  //     'cancel',
  //     false,
  //     ScanMode.BARCODE,
  //   )!.listen((barcode) { _barcodeReader = barcode;});
  // }

  bool isLoading =false;

  void searchWithAI(XFile selectedFile) async {
    setState(() {
      if (selectedFile != null) {
        final file = File(selectedFile!.path);
        final gemini = Gemini.instance;

        gemini.textAndImage(

            generationConfig: GenerationConfig(  temperature:0 /*0.5,
              maxOutputTokens: 100,
              topP: 1.0,
              topK: 40,*/),
            text:
            "what is the brand name and  the country developed it?, making the response exactly in this format: brand name:, brand country:",

            /// text
            images: [file.readAsBytesSync()]

          /// list of images
        ).then((value) {
          setState(() {

            log(value?.content?.parts?.last.text ?? '');
            final response = value?.content?.parts?.last.text ?? '';
            isLoading = false;

            print('hello world');
            print(response);
            showDialog(
              context: context,
              builder: (context) => Center(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'AI response',
                          style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          response,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    label: Text('OK',
                                        style: TextStyle(color: Colors.green)))),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        )
                      ],
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                  )),
            );
          });
        }).catchError((e){
          setState(() {
            isLoading = false;
            // showErrorMessage(context, 'No available data');
          });
        });
      }
    });
  }






  void SearchProductBaycoot(String Item) async{
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
          Country: item['brand_origin_country']['name'] == null ? '' : item['brand_origin_country']['name'],
          Name: item['brand_name'],
          id: item['id']));
    }
    setState(() {
      AllItemBaycoot = loadItem;
    });
  }


  void SearchProduct(String Item) async {
    final url = Uri.parse('https://alternatifurunler.com/api/brandsAlternative/search/${Item}?location_id=$CountryId');

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

  List<GridItemModel> AllItem =[];
  Future<List<GridItemModel>> _loadItems() async {
    final url = Uri.parse('https://alternatifurunler.com/api/brands');
    final response = await http.get(url);
    final Map<String, dynamic> listdata = json.decode(response.body);
    final List<GridItemModel> _loadedItems= [];


    for(final item in listdata['data']){
      _loadedItems.add(GridItemModel(isBaycoot: item['isAlternative'], image: item['brand_logo'], Details: item['brand_description'], Type: 'product', FoundYear: '1995', Country: item['brand_origin_country'] == null ? '' : item['brand_origin_country']['name'] ?? '', Name: item['brand_name'],  id: item['id']));
    }
    AllItem = _loadedItems;
    return _loadedItems;
  }

  List<GridItemModel> AllItemnotbaycoot =[];
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
    AllItemnotbaycoot = _loadedItems1;
    return _loadedItems1;
  }

  void _goToLocalBrands(){
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => PopularLocalBrands(localBrands: AllItemnotbaycoot,)));
  }
  void _goToForiegnBrands(){
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => PopularForiegnBrands(ForiegnBrands: AllItem,)));
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Color(0xFF009639)
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
                                  SearchProductBaycoot(value);
                                  Searched = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  ),
                                  hintText: '36'.tr,
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
                          InkWell(
                            onTap: () {
                                openCamera();
                            },
                            child: Container(
                              width: 40,
                              height: 65,
                              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),
                              child: Image.asset('assets/images/scan.png'),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          InkWell(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              if(image !=null)
                                searchWithAI(image);
                            },
                            child: Container(
                              width: 40,
                              height: 65,
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                              child: Image.asset('assets/images/camera.png'),
                            ),
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
          FutureBuilder(future: loadedItems, builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator(),);
            else if (snapshot.hasError)
              return Center(child: Text(snapshot.error.toString()));

            else if (snapshot.data!.isEmpty)
              return Center(child: Text("No items added yet"));
            else
              return Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "1".tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: _goToLocalBrands,
                        child: Row(
                          children: [
                            Text(
                              "2".tr,
                            ),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GridView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          childAspectRatio: 3 / 2,
                          mainAxisSpacing: 20,
                        ),
                        children: Searched.isEmpty ? List.generate(
                          AllItemnotbaycoot.length >= 6 ? 6 : AllItemnotbaycoot.length,
                              (index) => GridItem(Item: AllItemnotbaycoot[index]),
                        ) : AllItemNotBaycoot.isNotEmpty ? List.generate(AllItemNotBaycoot.length >= 6 ? 6 : AllItemNotBaycoot.length, (index) =>
                        GridItem(Item: AllItemNotBaycoot[index])): []),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        "3".tr,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: _goToForiegnBrands,
                        child: Row(
                          children: [
                            Text(
                              "2".tr,
                            ),
                            Icon(Icons.arrow_forward)
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: GridView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          childAspectRatio: 3 / 2,
                          mainAxisSpacing: 20,
                        ),
                        children: Searched.isEmpty ? List.generate(
                          6,
                              (index) => GridItem(Item: AllItem[index]),
                        ) : AllItemBaycoot.isNotEmpty ? List.generate(AllItemBaycoot.length >= 6 ? 6 : AllItemBaycoot.length, (index) =>
                            GridItem(Item: AllItemBaycoot[index])): []),
                  ),
                ],
              );
          })
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
