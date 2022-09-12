import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:justpark/Data/userdata.dart';
import 'package:justpark/Theme/deftheme.dart';
import 'package:justpark/widget/cardlist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        userProfile,
                        fit: BoxFit.fill,
                        width: 40,
                        height: 40,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello",
                          style: TextStyle(
                              color: primary2Color,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Text(
                          userName,
                          style: TextStyle(
                              color: primary2Color,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                      ]),
                  const Spacer(),
                  SvgPicture.asset("assets/icon/notification.svg",
                      width: 25, height: 25),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Finding a space to PARK ?",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    "We got YOU !",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Text(
                    "Just Park",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(254, 243, 138, 117)),
                  ),
                ],
              ),
            ),
            Container(
                width: width,
                height: height / 1.43,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35),
                      topRight: Radius.circular(35)),
                  color: Colors.white,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment., im back brother
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 60, bottom: 40),
                        child: Container(
                          height: 40,
                          width: width - 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(35),
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const Text(
                        "Nearby Space",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                      const CardList()
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
