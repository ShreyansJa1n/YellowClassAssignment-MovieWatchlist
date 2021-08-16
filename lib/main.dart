import 'package:flutter/material.dart';
import 'package:yellow_class_assignment/screens/movielist.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          iconTheme: IconThemeData(color: Colors.black),
          accentColor: Color(0xFF2B2D42),
          fontFamily: 'Mont',
          textTheme: TextTheme(
              bodyText1: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 24))),
      home: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Center(
                    child: Text('Error with FirebaseCore and Google Signin')),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return MovieListScreen();
            }

            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }),
    );
  }
}




// SafeArea(
//           child: Container(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 40.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 60),
//                     child: Text(
//                       "Hey 👋🏼",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 48,
//                           fontFamily: 'SF'),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: Text(
//                       "Your watched movie list",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 24,
//                           fontFamily: 'SF'),
//                     ),
//                   ),
//                   Expanded(
//                     child: ListView.builder(
//                         itemBuilder: (BuildContext context, int index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 10.0),
//                         child: Container(
//                           height: 90,
//                           decoration: BoxDecoration(
//                               color: Color(0xFF4E598C),
//                               borderRadius: BorderRadius.circular(17)),
//                           width: double.infinity,
//                         ),
//                       );
//                     }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),