import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:justpark/Theme/deftheme.dart';
import 'package:justpark/widget/parkingcard.dart';

class ParkingScreen extends StatefulWidget {
  final String parkingID;
  const ParkingScreen({Key? key, required this.parkingID}) : super(key: key);

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> cardata1 = FirebaseFirestore.instance
        .collection('Parking/${widget.parkingID}/Slots')
        .snapshots();
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Image.asset('assets/icon/backbutton.png')),
          title: Text(
            "Find Your Space",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: primary2Color),
          ),
          centerTitle: true,
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: StreamBuilder<QuerySnapshot>(
          stream: cardata1,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text('Something Went Wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.requireData;
            return Column(children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icon/gate.svg"),
                  SvgPicture.asset("assets/icon/Gate-2.svg"),
                  SvgPicture.asset("assets/icon/gate.svg"),
                ],
              ),
              SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(15),
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: data.size,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                    itemBuilder: ((context, index) => ParkingCard(
                        index: index + 1, slot: data.docs[index]["slot"]))),
              ))
            ]);
          },
        ));
  }
}
