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

  dynamic getCardData() {
    DatabaseReference parkingPlaceData =
        FirebaseDatabase.instance.ref('/Parking');
    parkingPlaceData.onValue.listen((DatabaseEvent event) async {
      final temp = event.snapshot.value;
      // var jsonUser = jsonEncode(data);
      data = temp;
      setState(() {
        loader = false;
      });
      print(data[1]["available"]);
    });
  }

  @override
  initState() {
    getCardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(data);
    return loader
        ? const Text("loading")
        : ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) => Cards(
                  name: data[index]["name"],
                  image: data[index]["image"],
                  slot: data[index]["available"],
                  parkingID: "123456",
                ));
  }
}
