import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homescreen2 extends StatefulWidget {
  const Homescreen2({super.key});

  @override
  State<Homescreen2> createState() => _Homescreen2State();
}

class _Homescreen2State extends State<Homescreen2> {
  CollectionReference collectionref =
      FirebaseFirestore.instance.collection("employees");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: StreamBuilder(
        //   stream: collectionref.snapshots(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       return Center(
        //         child: const Text("something went wrong"),
        //       );
        //     }
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       return Center(
        //         child: CircularProgressIndicator(),
        //       );
        //     }

        //   },
        // ),
        );
  }
}
