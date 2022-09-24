import 'package:flutter/material.dart';

class ParkingCard extends StatelessWidget {
  final int index;
  final bool slot;
  const ParkingCard({super.key, required this.index, required this.slot});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Card(
      shape: const RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        child: Column(
          children: [
            Text(
              "Slots $index",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 8,
            ),
            slot
                ? RotatedBox(
                    quarterTurns: 2, child: Image.asset("assets/image/Car.png"))
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
