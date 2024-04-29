import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/view/login_page/login.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  CollectionReference collectionref =
      FirebaseFirestore.instance.collection("employees");
  TextEditingController usernamecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
              icon: Icon(Icons.arrow_back))
        ],
      ),
      body: StreamBuilder(
        stream: collectionref.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: const Text("something went wrong"),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          log(snapshot.data!.docs.length.toString());
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
            child: Column(
              children: [
                TextField(
                  controller: usernamecontroller,
                  decoration: InputDecoration(
                    hintText: "username",
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: phonecontroller,
                  decoration: InputDecoration(
                    hintText: "phone number",
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      final data = {
                        "name": usernamecontroller.text,
                        "phone": phonecontroller.text,
                      };
                      collectionref.add(data);
                      usernamecontroller.clear();
                      phonecontroller.clear();
                    },
                    style: ButtonStyle(),
                    child: Text("Add")),
                Expanded(
                  child: ListView.separated(
                      itemBuilder: (context, index) => ListTile(
                            title: Text(
                              snapshot.data!.docs[index]["name"],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              snapshot.data!.docs[index]["phone"],
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        final data = {
                                          "name": usernamecontroller.text,
                                          "phone": phonecontroller.text,
                                        };
                                        collectionref
                                            .doc(snapshot.data!.docs[index].id)
                                            .update(data);
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        collectionref
                                            .doc(snapshot.data!.docs[index].id)
                                            .delete();
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 20,
                          ),
                      itemCount: snapshot.data!.docs.length),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
