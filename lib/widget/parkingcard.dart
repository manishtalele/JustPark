import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ParkingCard extends StatefulWidget {
  const ParkingCard({super.key});

  @override
  State<ParkingCard> createState() => _ParkingCardState();
}

class _ParkingCardState extends State<ParkingCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width / 2.5,
      height: width / 2.5,
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black, //color of border
            width: 1, //width of border
          ),
        ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset("assets/icon/notification.svg"),
      ),
    );
  }
}
