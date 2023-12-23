import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'App2.dart';
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

