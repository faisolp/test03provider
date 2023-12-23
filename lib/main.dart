import 'package:flutter/material.dart';


//import 'App1.dart';// demo basic Navigator
//import 'App2.dart';// demo Widget
import 'App3.dart';//demo Widget +Navigator


//import 'providers/userprofile.provider.dart';

/**
 * 
 *  return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) {
            return ProfileProvider();
          }),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          home: MyHomePage(),
        ));
 */

/*void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: MyApp(),
    ),
  );
}*/

void main() {
  runApp(MyApp());
}

