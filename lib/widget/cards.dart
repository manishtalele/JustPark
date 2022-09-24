import 'package:flutter/material.dart';
import 'package:justpark/Screen/parkingscreen.dart';
import 'package:justpark/Theme/deftheme.dart';

class Cards extends StatelessWidget {
  final String image, name, parkingID;
  final bool slot;
  const Cards(
      {super.key,
      required this.image,
      required this.name,
      required this.slot,
      required this.parkingID});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 18, right: 18),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ParkingScreen(
                      parkingID: parkingID,
                    ))),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: cardBg,
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    image,
                    height: 90,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(slot ? 'Available' : 'Unavailable',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: slot ? Colors.green : Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
