import 'dart:io';

import 'package:flutter/material.dart';
import 'package:upload/local_storage.dart';

class HOMEV extends StatefulWidget {
  const HOMEV({super.key});

  @override
  State<HOMEV> createState() => _HOMEVState();
}

class _HOMEVState extends State<HOMEV> {
  bool ispressed = false;
  void togpressed() {
    setState(() {
      ispressed = !ispressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: LocalStorage.getdata(LocalStorage.imageK),
              builder: (context, snapshot) {
                return CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color.fromARGB(255, 232, 142, 205),
                  backgroundImage: FileImage(File(snapshot.data!)),
                );
              },
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: togpressed,
              child: ispressed
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 11, 11, 11)),
                        decoration: const InputDecoration(
                          hintText: "enter your name",
                          hintStyle: TextStyle(
                              color: Color.fromARGB(255, 15, 15, 15),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                          filled: true,
                          fillColor: Color.fromARGB(255, 232, 142, 205),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                        ),
                      ),
                    )
                  : Container(
                      height: 70,
                      width: 370,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 232, 142, 205),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25, left: 5),
                        child: FutureBuilder(
                          future: LocalStorage.getdata(LocalStorage.nameK),
                          builder: (context, snapshot) {
                            return Text(
                              '${snapshot.data}',
                              style: const TextStyle(fontSize: 20),
                            );
                          },
                        ),
                      ),
                    ),
            )
          ],
        ),
      ),
    ));
  }
}
