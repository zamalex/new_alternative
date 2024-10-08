import 'package:alternative_new/Screens/AddForiegnBrand.dart';
import 'package:alternative_new/Screens/AddLocalBrands.dart';
import 'package:alternative_new/Screens/ChangeLanguageScreen.dart';
import 'package:alternative_new/Screens/ContactusScreen.dart';
import 'package:alternative_new/Screens/EditProfileScreen.dart';
import 'package:alternative_new/Screens/addAlternative.dart';
import 'package:alternative_new/Screens/contact_us_web.dart';
import 'package:alternative_new/Screens/login_and_registerScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:alternative_new/main.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:get/get.dart';
import 'package:open_store/open_store.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({super.key});
  @override
  State<MyAccount> createState() {
    // TODO: implement createState
    return _MyAccount();
  }
}

class _MyAccount extends State<MyAccount> {
  SharedprefServices sharedprefServices = SharedprefServices();
  int Stateindex = 1;
  String? name;
  String? email;
  String? image;
  void LoadUserData() async {
    name = await sharedprefServices.readCache(key: 'name');
    email = await sharedprefServices.readCache(key: 'email');
    image = await sharedprefServices.readCache(key: 'image');
    print(name);
    print(email);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    LoadUserData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "5".tr,
          style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontWeight: FontWeight.w600,
              fontSize: 22),
        ),
        backgroundColor: Color(0xFF009639),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(color: kPrimaryColor),
        child: Container(
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),

          child: ListView(
            children: [
          
              SizedBox(
                height: 20,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                      child: InkWell(
                    onTap: () {},
                    child: CachedNetworkImage(
                      height: 100,
                      width: 100,
                      imageUrl: image ?? '',
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  )),
                  Image.asset('assets/images/camera11.png'),
                ],
              ),
              Center(
                child: Text(
                  name ?? '',
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              Center(
                child: Text(
                  email ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color.fromRGBO(217, 217, 217, 1)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                            MaterialPageRoute(builder: (ctx) => EditProfile()))
                        .then((value) => {LoadUserData()});
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.asset('assets/images/personIcon.png'),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "6".tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF009639)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF009639),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => AddLocalBrands()));
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.asset(
                              'assets/images/Union.png',
                              color: Color(0xFF009639),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "7".tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF009639)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF009639),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => AddForiegnBrands()));
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.asset(
                              'assets/images/Union.png',
                              color: Color(0xFF009639),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "8".tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF009639)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF009639),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => ChangeLanguageScreen()));
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.asset(
                              'assets/images/Language.png',
                              color: Color(0xFF009639),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "9".tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF009639)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF009639),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () async {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (ctx) => ContactUsWeb()));
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.asset(
                              'assets/images/headphones.png',
                              color: Color(0xFF009639),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "10".tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF009639)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF009639),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    OpenStore.instance.open(
                      appStoreId: '6471507542', // AppStore id of your app for iOS
                      appStoreIdMacOS:
                          '6471507542', // AppStore id of your app for MacOS (appStoreId used as default)
                      androidAppBundleId:
                          'com.sahla.boycott', // Android app bundle package name
                      // windowsProductId: '9NZTWSQNTD0S' // Microsoft store id for Widnows apps
                    );
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.star,
                              color: Color(0xFF009639),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "11".tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF009639)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFF009639),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    sharedprefServices.removeCache();
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => LoginAndRegisterScreen()));
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.logout_sharp,
                              color: Color(0xFFED2E38),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "12".tr,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFED2E38)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFED2E38),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),  SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: InkWell(
                  onTap: () {
                    showDeleteDialog(context);
          
          
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Icon(
                              Icons.delete,
                              color: Color(0xFFED2E38),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Delete Account',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFFED2E38)),
                          ),
                          Spacer(),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFED2E38),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                  ),
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
          if (Stateindex == 0) {
            Navigator.pop(context);
          }
        },
        currentIndex: Stateindex,
        selectedItemColor: Colors.white,
        backgroundColor: Color(0xFF009639),
      ),
    );
  }
}

showDeleteDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Delete"),
    onPressed: () {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (ctx) => LoginAndRegisterScreen()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Careful"),
    content: Text("Would you like to continue deleting your account?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
/*Future deleteAccount(int id) async {
  try {
    Response response =
    await sl<DioClient>().delete('${Url.DELETE_USER_URL}/${id}');

    return {'message': '', 'data': false};
  } catch (e) {

  }
}*/