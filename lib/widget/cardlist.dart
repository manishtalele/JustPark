import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:justpark/widget/cards.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  late var data;
  List dat = [];
  bool loader = true;
  @override
  initState() {
    DatabaseReference parkingPlaceData =
        FirebaseDatabase.instance.ref('/Parking');
    parkingPlaceData.onValue.listen((DatabaseEvent event) {
      data = event.snapshot.value;
      var jsonUser = jsonEncode(data);
      setState(() {
        // dat = jsonDecode(data);
        loader = false;
      });
      print(jsonUser[1]);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(data);
    return loader
        ? const Text("loading")
        : ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) => const Cards(
                  image:
                      "https://cdn.pixabay.com/photo/2020/09/06/07/37/car-5548242_1280.jpg",
                  name: "Dadar",
                  slot: true,
                  parkingID: "123456",
                ));
  }
}
