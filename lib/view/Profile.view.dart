import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Router/PageRouter.dart';
import '../providers/userprofile.provider.dart';

class ProfileScreen extends StatelessWidget {
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
            child: Text('Go Back'),
            onPressed: () {
              PageRouter.of(context)?.goTo('/home');
            },
          ),
        ],
      ),
    );
  }
}
