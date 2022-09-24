import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:justpark/Data/userdata.dart';
import 'package:justpark/widget/cards.dart';

class CardList extends StatefulWidget {
  const CardList({Key? key}) : super(key: key);

  @override
  State<CardList> createState() => _CardListState();
}

class _CardListState extends State<CardList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: cardData,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something Went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading data');
        }
        final data = snapshot.requireData;
        return ListView.builder(
            shrinkWrap: true,
            itemCount: data.size,
            itemBuilder: (context, index) => Cards(
                  image: data.docs[index]["image"],
                  name: data.docs[index]["name"],
                  slot: data.docs[index]["slots"],
                  parkingID: data.docs[index].id,
                ));
      },
    );
  }
}
