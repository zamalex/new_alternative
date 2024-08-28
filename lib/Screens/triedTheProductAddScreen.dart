import 'dart:io';

import 'package:alternative_new/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:alternative_new/Model/GridItemModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:alternative_new/main.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TriedTheProductAdd extends StatefulWidget {
  const TriedTheProductAdd({super.key, required this.isBaycoot, required this.flag});

  final int isBaycoot;
  final int flag;
  @override
  State<TriedTheProductAdd> createState() {
    // TODO: implement createState
    return _TriedTheProductAdd();
  }
}

class _TriedTheProductAdd extends State<TriedTheProductAdd> {
  final _formkey = GlobalKey<FormState>();
  String? _enteredName;
  String? _enteredDescription;
  String? _enteredNotes;
  String? _enteredImage;
  String? token;

  void initial() async {
    final SharedprefServices pref = new SharedprefServices();
    token = await pref.readCache(key: "token");
  }
  @override
  void initState() {
    // TODO: implement initState
    initial();
  }
  void _saveItembaycoot() async {
    final url = Uri.parse('https://alternatifurunler.com/api/brands');
    final request = await http.MultipartRequest('POST', url);
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token!
    };
    request.fields.addAll({'name': _enteredName!,
      'description': _enteredDescription!,
      'notes': _enteredNotes!,
      'is_alternative': '0',
    });
    request.files.add(
        await http.MultipartFile.fromPath('image', _enteredImage!));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    print('trying to add foreign brand');
    if(response.statusCode >= 200 && response.statusCode <205)
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
    else
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error has occered'), duration: Duration(seconds: 3),));
  }

  void _saveItemnotbaycoot() async {
    final url = Uri.parse('https://alternatifurunler.com/api/brandsAlternative');
    final request = await http.MultipartRequest('POST', url);
    var headers = {
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + token!
    };
    request.fields.addAll({'name': _enteredName!,
      'description': _enteredDescription!,
      'notes': _enteredNotes!,
    });
    request.files.add(
        await http.MultipartFile.fromPath('image', _enteredImage!));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print(response.statusCode);
    final json1 = await response.stream.bytesToString();
    final Map<String, dynamic> listdata = json.decode(json1);
    print(json1);
    print('trying to add local brand');
    if (response.statusCode >= 200 && response.statusCode < 205) {
      if (widget.flag != 0) {
        print(widget.flag);
        final url = Uri.parse(
            "https://alternatifurunler.com/api/brands_sync_brandsAlternative");
        final response = await http.post(url, headers: {
          'Content-Type' : 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token!,
        },
            body: json.encode({
              'brand_id' : widget.flag.toString(),
              'alternative_id': listdata["data"]["id"]
            }));
        print({
          'brand_id' : widget.flag.toString(),
          "alternative_brand": listdata["data"]["id"].toString()
        });
        print(response.statusCode);
        print(response.body);
        if(response.statusCode >= 200 && response.statusCode <205)
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => HomePage()));
        else
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('An error has occered'), duration: Duration(seconds: 3),));
      }
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => HomePage()));
    }else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('An error has occured'),
        duration: Duration(seconds: 3),));
    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: Text(
          '20'.tr,
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
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(12)),

          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [

                SizedBox(
                  height: 40,
                ),
                Text(
                  "22".tr,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "23".tr,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        children: [
                          Container(
                            height: 50,
                            child: TextFormField(
                              onSaved: (value){
                                _enteredName = value;
                              },
                              validator: (value) {
                                if(value!.isEmpty)
                                  return '50'.tr;
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.layers,
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: '51'.tr,
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  )),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 50,
                            child: TextFormField(
                              onSaved: (value){
                                _enteredDescription = value;
                              },
                              validator: (value) {
                                if(value!.isEmpty)
                                  return '50'.tr;
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.info_outline,
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: '52'.tr,
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  )),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 50,
                            child: TextFormField(
                              validator: (value) {
                                if(value!.isEmpty)
                                  return '50'.tr;
                                return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.flag,
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: '28'.tr,
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  )),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 250,
                            child: TextFormField(
                              onSaved: (value){
                                _enteredNotes = value;
                              },
                              validator: (value) {
                                if(value!.isEmpty)
                                  return '50'.tr;
                                return null;
                              },
                              maxLines: 8,
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.info_outline,
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: '53'.tr,
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(217, 217, 217, 20),
                                  )),
                            ),
                          ),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: () async{
                              final ImagePicker picker = ImagePicker();
                              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                              _enteredImage = image!.path.toString();
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
                                    Text("56".tr, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20,fontWeight: FontWeight.w600),),
                                    SizedBox(width: 10,),
                                    Icon(Icons.arrow_forward, color: Color(0xFFFFFFFF),),
                                  ]),
                            ),
                          ),
                          SizedBox(height: 20,),
                          InkWell(
                            onTap: () {
                              if(_formkey.currentState!.validate()) {
                                _formkey.currentState!.save();
                                if (widget.isBaycoot == 1) {
                                  _saveItembaycoot();
                                } else if (widget.isBaycoot == 0) {
                                  _saveItemnotbaycoot();
                                }
                              }
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
                                    Text("24".tr, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 20,fontWeight: FontWeight.w600),),
                                    SizedBox(width: 10,),
                                    Icon(Icons.arrow_forward, color: Color(0xFFFFFFFF),),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
