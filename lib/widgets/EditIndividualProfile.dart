import 'package:flutter/material.dart';

class EditIndividualProfile extends StatefulWidget{
  const EditIndividualProfile({super.key});

  @override
  State<EditIndividualProfile> createState() {
    // TODO: implement createState
    return _EditIndividualProfile();
  }
}

class _EditIndividualProfile extends State<EditIndividualProfile>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            height: 44,
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color.fromRGBO(217, 217, 217, 20),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Full Name',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(217, 217, 217, 20),
                  )),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 44,
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.phone_android_sharp,
                    color: Color.fromRGBO(217, 217, 217, 20),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Phone Number',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(217, 217, 217, 20),
                  )),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 44,
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Color.fromRGBO(217, 217, 217, 20),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(217, 217, 217, 20),
                  )),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            height: 44,
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color.fromRGBO(217, 217, 217, 20),
                  ),
                  suffixIcon: Icon(
                    Icons.visibility_off,
                    color: Color.fromRGBO(217, 217, 217, 20),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(217, 217, 217, 20),
                  )),
            ),
          ),

        ],
      ),
    );
  }
}