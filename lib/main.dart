import 'package:alternative_new/Locale/loacle.dart';
import 'package:alternative_new/Locale/locale_controller.dart';
import 'package:alternative_new/Screens/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:alternative_new/Screens/login_and_registerScreen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:country_ip/country_ip.dart';
bool isSaved = false;
int? CountryId;
void main() async{
  MyLocaleController controller = Get.put(MyLocaleController());
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: 'AIzaSyAXyqfMsYMXtTcHIJv6y3a3nmRo9lnvFbY');
  SharedprefServices sharedprefServices = SharedprefServices();
  String? token = await sharedprefServices.readCache(key: 'token');
  String? lang = await sharedprefServices.readCache(key: "lang");
  if(lang == "ar")
    controller.initialLang = Locale("ar");
  if(lang == "en")
    controller.initialLang = Locale("en");
  if(lang == "tr")
    controller.initialLang = Locale("tr");
  if(token == null)
    isSaved =false;
  else
    isSaved =true;
  final countryIpResponse = await CountryIp.find();
  final countryName = countryIpResponse?.country;

  if(countryName == "Turkey")
    CountryId = 225;
  else if(countryName == "Egypt")
    CountryId = 65;
  // User's country : United States
  // User's ip : 9.9.9.9
  runApp(const MyApp());
}



class SharedprefServices{
  Future writeCache({required String key, required String value}) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    isSaved = await pref.setString(key, value);

  }

  Future? readCache({required String key}) async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? value = await pref.getString(key);
    return value;
  }

  Future removeCache() async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool isCleared = await pref.clear();
    isSaved = false;
    print(isSaved);
  }
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedprefServices sharedprefServices = SharedprefServices();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(MyLocaleController());

   MyLocaleController controller = Get.put(MyLocaleController());
    // print(sharedprefServices.readCache(key: 'token'));
    return GetMaterialApp(
      locale: controller.initialLang,
      translations: MyLocale(),
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isSaved == false ? LoginAndRegisterScreen() : HomePage(),

    );
  }
}

