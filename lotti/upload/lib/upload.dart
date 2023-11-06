import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:upload/home.dart';
import 'package:upload/local_storage.dart';

String? imagepath;
String names="";


class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  void initState() {
    super.initState();
    LocalStorage.getdata(LocalStorage.imageK).then((value) {
      //then بتبقي لازم احطها في الفانكشن الي فيها future
      setState(() {
        imagepath = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [
          const Padding(
            padding: EdgeInsets.only(top: 15),
            child: Text(
              "Done",
              style: TextStyle(
                  color: Color.fromARGB(255, 91, 7, 59), fontSize: 20),
            ),
          ),
          IconButton(
              onPressed: () {
                if (imagepath != null && names.isNotEmpty ) {
                  LocalStorage.savedata(LocalStorage.nameK, names);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HOMEV(),));
                
                } else if (imagepath == null && names .isEmpty){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color.fromARGB(255, 75, 2, 50),
                  
                    content: Text("pleas enter your image and your name")));
                  //دا اسناك بار هيطلع بالماسيدج الي مكتوبه في التكيست لو في مشكله في الصورة او الاسم 

                } else if (imagepath == null){
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color.fromARGB(255, 75, 2, 50),
                    content: Text("pleas enter your image ")));

                }else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    backgroundColor: Color.fromARGB(255, 75, 2, 50),
                    content: Text("pleas enter your name")));
                }
              },
              icon: const Icon(
                Icons.check,
                color: Color.fromARGB(255, 91, 7, 59),
              ))
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: (imagepath != null)
                ? FileImage(File(imagepath!)) as ImageProvider
                : const AssetImage("assets/tulip.webp"),
            //مش هتعرف على الفايل ك image provider و ال background image بترجع image provider علشان كدا بقوله ان الفايل as image provider
            // علشان بحط نوعين مختلفين
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              getimagefromcamera();
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(170, 50),
                backgroundColor: const Color.fromARGB(255, 226, 75, 153),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            child: const Text("upload from camera"),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              getimagefromgallery();
            },
            style: ElevatedButton.styleFrom(
                fixedSize: const Size(170, 50),
                backgroundColor: const Color.fromARGB(255, 226, 75, 153),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            child: const Text("upload from gallery"),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Divider(
              color: Color.fromARGB(255, 79, 19, 60),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              onChanged: (value) {//علشان امسك الtext الي انا بكتبه
                setState(() {
                  names=value;
                });
              },
              cursorColor: Colors.black,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: "enter your name",
                hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                filled: true,
                fillColor: Color.fromARGB(255, 196, 62, 149),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
              ),
            ),
          )
        ],
      )),
    ));
  }

  getimagefromcamera() async {
    final pickedimage = await ImagePicker().pickImage(
        source: ImageSource.camera); //علشان هتحتاج وقت لحد ماتيجي فبحط await
    if (pickedimage != null) {
      LocalStorage.savedata(LocalStorage.imageK, pickedimage.path);
      setState(() {
        imagepath = pickedimage.path;
      });
    }
  }

  getimagefromgallery() async {
    final pickedimage = await ImagePicker().pickImage(
        source: ImageSource.gallery); //علشان هتحتاج وقت لحد ماتيجي فبحط await
    if (pickedimage != null) {
      LocalStorage.savedata(LocalStorage.imageK, pickedimage.path);
      setState(() {
        imagepath = pickedimage.path;
      });
    }
  }
}
