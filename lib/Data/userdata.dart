import 'package:cloud_firestore/cloud_firestore.dart';

String userName = "UserName",
    userProfile =
        "https://media.istockphoto.com/photos/headshot-portrait-of-smiling-ethnic-businessman-in-office-picture-id1300512215?b=1&k=20&m=1300512215&s=170667a&w=0&h=LsZL_-vvAHB2A2sNLHu9Vpoib_3aLLkRamveVW3AGeQ=";

final Stream<QuerySnapshot> cardData =
    FirebaseFirestore.instance.collection('Parking').snapshots();
