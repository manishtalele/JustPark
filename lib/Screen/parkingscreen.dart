import 'package:flutter/material.dart';
import 'package:justpark/Theme/deftheme.dart';
import 'package:justpark/widget/parkingcard.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({Key? key}) : super(key: key);

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Your Space"),
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                ParkingCard(),
                ParkingCard(),
                ParkingCard(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Container(width: 1, color: Colors.black,),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ParkingCard(),
                const ParkingCard(),
                Container(height: width/2,width: width/2,color: primaryColor,),
                Container(height: 1,width: width/3,color: Colors.black,)
              ],
            ),
          )
        ],
      ),
    );
  }
}