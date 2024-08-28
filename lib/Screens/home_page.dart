import 'dart:developer';
import 'dart:ui';
import 'package:alternative_new/Screens/login_and_registerScreen.dart';
import 'package:alternative_new/main.dart';
import 'dart:convert';
import 'package:alternative_new/Locale/locale_controller.dart';
import 'package:alternative_new/widgets/custom_widgets.dart';
import 'package:country_ip/country_ip.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:alternative_new/Screens/baycootItemDetails.dart';
import 'package:alternative_new/Screens/itemDetailsScreen.dart';
import 'package:alternative_new/Screens/popularForiegnBrands.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
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
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  int Stateindex = 0;
  int CurrentScreenState = 0;
  List<GridItemModel> AllItemNotBaycoot = [];
  List<GridItemModel> AllItemBaycoot = [];
  String Searched = '';

  List<GridItemModel> AllItem = [];
  List<GridItemModel> AllItemnotbaycoot = [];

  late Future<List<GridItemModel>> loadedItems;
  late Future<List<GridItemModel>> loadedItemsnotBaycoot;

  int foreignPage = 1;
  int localPage = 1;
  bool isLoadingMoreForeign = false;
  bool isLoadingMoreLocal = false;
  bool hasMoreForeign = true;
  bool hasMoreLocal = true;

  @override
  void initState() {
    super.initState();
    loadedItems = _loadItems(page: foreignPage);
    loadedItemsnotBaycoot = _loadItemsnotBaycoot(page: localPage);
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

    setState(() {
      _scanBarcodeResult = _barcodeReader;
    });

    final url = Uri.parse(
        'https://alternatifurunler.com/api/brands/search/$_scanBarcodeResult');
    final response = await http.get(url);
    final Map<String, dynamic> listdata = json.decode(response.body);
    final List<GridItemModel> loadeditem = [];

    if (listdata.isEmpty) {
      final url = Uri.parse(
          'https://alternatifurunler.com/api/brandsAlternative/search/$_scanBarcodeResult');
      final response = await http.get(url);
      final Map<String, dynamic> listdata = json.decode(response.body);
      for (final item in listdata['data']) {
        loadeditem.add(GridItemModel(
          isBaycoot: 0,
          image: item['brand_logo'],
          Details: item['brand_description'],
          Type: 'product',
          FoundYear: item['brand_year_founderd'] == null
              ? ''
              : item['brand_year_founderd'],
          Country: item['brand_origin_country'] == null
              ? ''
              : item['brand_origin_country']['name'] == null
              ? ''
              : item['brand_origin_country']['name'],
          Name: item['brand_name'],
          id: item['id'],
        ));
      }
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => ItemDetails(Item: loadeditem[0])));
      return;
    }

    for (final item in listdata['data']) {
      loadeditem.add(GridItemModel(
        isBaycoot: 0,
        image: item['brand_logo'],
        Details: item['brand_description'],
        Type: 'product',
        FoundYear: item['brand_year_founderd'] == null
            ? ''
            : item['brand_year_founderd'],
        Country: item['brand_origin_country'] == null
            ? ''
            : item['brand_origin_country']['name'] == null
            ? ''
            : item['brand_origin_country']['name'],
        Name: item['brand_name'],
        id: item['id'],
      ));
    }
    Navigator.of(context).push(MaterialPageRoute(
        builder: (ctx) => BaycootItemDetails(Item: loadeditem[0])));
    return;
  }

  void searchWithAI(XFile selectedFile) async {
    setState(() {
      if (selectedFile != null) {
        final file = File(selectedFile!.path);
        final gemini = Gemini.instance;

        gemini.textAndImage(
          generationConfig: GenerationConfig(temperature: 0),
          text:
          "what is the brand name and the country developed it?, making the response exactly in this format: brand name:, brand country:",
          images: [file.readAsBytesSync()],
        ).then((value) {
          setState(() {
            log(value?.content?.parts?.last.text ?? '');
            final response = value?.content?.parts?.last.text ?? '';
            isLoadingMoreForeign = false;
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
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        response,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.check, color: Colors.green),
                              label: Text('OK',
                                  style: TextStyle(color: Colors.green)),
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      )
                    ],
                  ),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                ),
              ),
            );
          });
        }).catchError((e) {
          setState(() {
            isLoadingMoreForeign = false;
          });
        });
      }
    });
  }

  void SearchProductBaycoot(String Item) async {
    final url =
    Uri.parse('https://alternatifurunler.com/api/brands/search/${Item}');
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    List<GridItemModel> loadItem = [];
    for (final item in listData['data']) {
      loadItem.add(GridItemModel(
        isBaycoot: 0,
        image: item['brand_logo'],
        Details: item['brand_description'],
        Type: 'product',
        FoundYear: item['brand_year_founderd'] == null
            ? ''
            : item['brand_year_founderd'],
        Country: item['brand_origin_country'] == null
            ? ''
            : item['brand_origin_country']['name'] == null
            ? ''
            : item['brand_origin_country']['name'],
        Name: item['brand_name'],
        id: item['id'],
      ));
    }
    setState(() {
      AllItemBaycoot = loadItem;
    });
  }

  void SearchProduct(String Item) async {
    final url = Uri.parse(
        'https://alternatifurunler.com/api/brandsAlternative/search/${Item}?location_id=$CountryId');

    final response = await http.get(url);
    final Map<String, dynamic> listdata = json.decode(response.body);
    print(response.body);
    final List<GridItemModel> _loadedItems1 = [];
    for (final item in listdata['data']) {
      _loadedItems1.add(GridItemModel(
        isBaycoot: 1,
        image: item['brand_logo'],
        Details: item['brand_description'] == null
            ? ''
            : item['brand_description'] ?? '',
        Type: 'product',
        FoundYear: '1995',
        Country: item['brand_origin_country'] == null
            ? ''
            : item['brand_origin_country']['name'] ?? '',
        Name: item['brand_name'],
        id: item['id'],
      ));
    }
    setState(() {
      AllItemNotBaycoot = _loadedItems1;
    });
  }

  Future<List<GridItemModel>> _loadItems({int page = 1}) async {
    final url = Uri.parse(
        'https://alternatifurunler.com/api/brands?per_page=28&page=$page');
    final response = await http.get(url);
    final Map<String, dynamic> listdata = json.decode(response.body);
    final List<GridItemModel> _loadedItems = [];

    for (final item in listdata['data']) {
      _loadedItems.add(GridItemModel(
        isBaycoot: item['isAlternative'],
        image: item['brand_logo'],
        Details: item['brand_description'],
        Type: 'product',
        FoundYear: '1995',
        Country: item['brand_origin_country'] == null
            ? ''
            : item['brand_origin_country']['name'] ?? '',
        Name: item['brand_name'],
        id: item['id'],
      ));
    }
    AllItem.addAll(_loadedItems);
    return _loadedItems;
  }

  Future<List<GridItemModel>> _loadItemsnotBaycoot({int page = 1}) async {
    final url = Uri.parse(
        'https://alternatifurunler.com/api/brandsAlternative?per_page=28&page=$page&location_id=$CountryId');
    final response = await http.get(url);
    final Map<String, dynamic> listdata1 = json.decode(response.body);
    final List<GridItemModel> _loadedItems1 = [];

    for (final item in listdata1['data']) {
      _loadedItems1.add(GridItemModel(
        isBaycoot: 1,
        image: item['brand_logo'],
        Details: item['brand_description'] == null
            ? ''
            : item['brand_description'] ?? '',
        Type: 'product',
        FoundYear: '1995',
        Country: item['brand_origin_country'] == null
            ? ''
            : item['brand_origin_country']['name'] ?? '',
        Name: item['brand_name'],
        id: item['id'],
      ));
    }
    AllItemnotbaycoot.addAll(_loadedItems1);
    return _loadedItems1;
  }

  void _loadMoreForeign() async {
    if (isLoadingMoreForeign || !hasMoreForeign) return;

    setState(() {
      isLoadingMoreForeign = true;
    });

    final List<GridItemModel> newItems = await _loadItems(page: foreignPage);

    setState(() {
      AllItem.addAll(newItems);
      isLoadingMoreForeign = false;
      foreignPage++;
      hasMoreForeign = newItems.length ==
          28; // Check if we got a full batch, meaning more pages are possible
    });
  }

  void _loadMoreLocal() async {
    if (isLoadingMoreLocal || !hasMoreLocal) return;

    setState(() {
      isLoadingMoreLocal = true;
    });

    final List<GridItemModel> newItems =
    await _loadItemsnotBaycoot(page: localPage);

    setState(() {
      AllItemnotbaycoot.addAll(newItems);
      isLoadingMoreLocal = false;
      localPage++;
      hasMoreLocal = newItems.length ==
          28; // Check if we got a full batch, meaning more pages are possible
    });
  }

  void _goToLocalBrands() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) =>
                PopularLocalBrands(localBrands: AllItemnotbaycoot)));
  }

  void _goToForiegnBrands() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => PopularForiegnBrands(ForiegnBrands: AllItem)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color(0xFF009639)),
        backgroundColor: Color(0xFF009639),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification.metrics.pixels ==
              scrollNotification.metrics.maxScrollExtent) {
            if (CurrentScreenState == 0) {
              _loadMoreForeign();
            } else if (CurrentScreenState == 1) {
              _loadMoreLocal();
            }
          }
          return false;
        },
        child: Container(
          decoration: BoxDecoration(color: kPrimaryColor),
          padding: EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text('welcome'.tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28)),
                ],
              ),
              Text('discover'.tr,
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                      margin: EdgeInsets.only(top: 45 / 2),
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              CustomTabBar(
                                selectedIndex: CurrentScreenState,
                                onTabSelected: (p0) {
                                  setState(() {
                                    CurrentScreenState = p0;
                                  });
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: SingleChildScrollView(
                              child: FutureBuilder(
                                future: loadedItems,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                    return Center(
                                        child: CircularProgressIndicator());
                                  else if (snapshot.hasError)
                                    return Center(
                                        child: Text(snapshot.error.toString()));
                                  else if (snapshot.data!.isEmpty)
                                    return Center(
                                        child: Text("No items added yet"));
                                  else
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        BoycottButton(isBoycott: CurrentScreenState==0,),

                                        if (CurrentScreenState == 1)
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: GridView.builder(
                                              physics:
                                              NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                crossAxisSpacing: 5,
                                                childAspectRatio: 1,
                                                mainAxisSpacing: 20,
                                              ),
                                              itemCount: Searched.isEmpty
                                                  ? AllItemnotbaycoot.length
                                                  : AllItemNotBaycoot.length,
                                              itemBuilder: (context, index) {
                                                final item = Searched.isEmpty
                                                    ? AllItemnotbaycoot[index]
                                                    : AllItemNotBaycoot[index];
                                                return GridItem(Item: item);
                                              },
                                            ),
                                          ),
                                        if (CurrentScreenState == 0)
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(right: 0),
                                            child: GridView.builder(
                                              physics:
                                              NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                crossAxisSpacing: 5,
                                                childAspectRatio: 1,
                                                mainAxisSpacing: 20,
                                              ),
                                              itemCount: Searched.isEmpty
                                                  ? AllItem.length
                                                  : AllItemBaycoot.length,
                                              itemBuilder: (context, index) {
                                                final item = Searched.isEmpty
                                                    ? AllItem[index]
                                                    : AllItemBaycoot[index];
                                                return GridItem(Item: item);
                                              },
                                            ),
                                          ),
                                        if (CurrentScreenState == 2)
                                          Padding(
                                            padding:
                                            const EdgeInsets.only(right: 0),
                                            child: GridView.builder(
                                              physics:
                                              NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 4,
                                                crossAxisSpacing: 5,
                                                childAspectRatio: 1,
                                                mainAxisSpacing: 20,
                                              ),
                                              itemCount: recentlyViewed.length,
                                              itemBuilder: (context, index) {
                                                final item = recentlyViewed[index];
                                                return GridItem(Item: item);
                                              },
                                            ),
                                          ),
                                        if (isLoadingMoreLocal ||
                                            isLoadingMoreForeign)
                                          Padding(
                                            padding: EdgeInsets.all(10),
                                            child: Center(
                                              child:
                                              CircularProgressIndicator(),
                                            ),
                                          )
                                      ],
                                    );
                                },
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 45,
                      child: Row(
                        children: [
                          SizedBox(width: 8),
                          Expanded(
                            child: PhysicalModel(
                              color: Colors.white,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: TextFormField(
                                style: TextStyle(
                                    color: Colors
                                        .black), // Ensure text color is visible

                                onChanged: (value) {
                                  SearchProduct(value);
                                  SearchProductBaycoot(value);
                                  Searched = value;
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SizedBox(width: 10),
                                        Container(
                                            height: 20,
                                            width: 50,
                                            child: CountryDropdown(
                                              selectedCountryId: CountryId ?? 0,
                                              onSelect: () {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage(),
                                                    ));
                                              },
                                            )),
                                        Icon(
                                          Icons.search,
                                          color:
                                          Color.fromRGBO(217, 217, 217, 20),
                                        )
                                      ]),
                                  hintText: '36'.tr,
                                  contentPadding: EdgeInsets.only(top: 10),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  ),
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              openCamera();
                            },
                            child: PhysicalModel(
                              color: Colors.white,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: Center(
                                child: Container(
                                  width: 40,
                                  height: 65,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Image.asset('assets/images/scan.png'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          InkWell(
                            onTap: () async {
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              if (image != null) searchWithAI(image);
                            },
                            child: PhysicalModel(
                              color: Colors.white,
                              elevation: 5,
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                width: 40,
                                height: 65,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12)),
                                child: Image.asset('assets/images/camera.png'),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
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
          if (Stateindex == 1) {
            if (isSaved)
              Navigator.push(
                  context, MaterialPageRoute(builder: (ctx) => MyAccount()));
            else
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => LoginAndRegisterScreen()));
          }
        },
        currentIndex: Stateindex,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xFF009639),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  CustomTabBar({required this.selectedIndex, required this.onTabSelected});

  final List<String> tabs = ['foreign'.tr, 'local'.tr, 'recent'.tr];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(tabs.length, (index) {
          return Expanded(
            child: InkWell(
              onTap: () => onTabSelected(index),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    tabs[index],
                    style: TextStyle(
                      fontSize: 11,
                      color: selectedIndex == index ? Colors.red : Colors.grey,
                      fontWeight: selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    height: 2,
                    width: double.infinity,
                    color: selectedIndex == index
                        ? Colors.red
                        : Colors.transparent,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class BoycottButton extends StatelessWidget {
  BoycottButton({this.isBoycott = true});
  bool isBoycott;
  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: isBoycott ? Colors.red : kPrimaryColor,
      strokeWidth: 1,
      dashPattern: [4, 2],
      borderType: BorderType.RRect,
      radius: Radius.circular(8),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isBoycott ? Icons.block : Icons.check_circle,
              color: isBoycott ? Colors.red : kPrimaryColor,
              size: 20,
            ),
            SizedBox(width: 8),
            Text(
              isBoycott ? 'Boycott' : 'Alternative',
              style: TextStyle(
                color: isBoycott ? Colors.red : kPrimaryColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
