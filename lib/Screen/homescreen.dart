import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:justpark/Data/userdata.dart';
import 'package:justpark/Theme/deftheme.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: secondaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                  children: const[
                     Text(
                      "Finding a space to PARK ?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white
                      ),
                    ),
                  
                 Text(
                  "We got YOU !",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white
                  ),
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
              // SizedBox(height: width - 200),
              Container(
                  color: Colors.white,
                  width: width,
                  height: height,
                  child: Column(
                    children:  const [
                      
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
