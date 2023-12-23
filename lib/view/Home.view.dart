import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Router/PageRouter.dart';
import '../providers/userprofile.provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<ProfileProvider>(
            builder: (context, profileProvider, child) {
              return Text('Counter: ${profileProvider.counter}');
            },
          ),
          ElevatedButton(
            child: Text('Increment'),
            onPressed: () => Provider.of<ProfileProvider>(context, listen: false).increment(),
          ),
          ElevatedButton(
            child: Text('Go to Profile Screen'),
            onPressed: () {
              PageRouter.of(context)?.goTo('/profile');
 
            },
          ),
        ],
      ),
    );
  }
}