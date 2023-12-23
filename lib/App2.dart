import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Layout/App/AppDrawerHeader.dart';
import 'Layout/App/AppDrawerItems.dart';
import 'Router/PageRouter.dart';
import 'providers/userprofile.provider.dart';
import 'tools/UI.tool.dart';
import 'view/Home.view.dart';
import 'view/Profile.view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget _currentWidget = HomeScreen();
final List<Map<String, dynamic>> routes = [
    {'route': '/home', 'title': 'Home', 'icon': 'home'},
    {'route': '/profile', 'title': 'Profile', 'icon': 'person'},
    // เพิ่ม routes อื่นๆ ที่นี่
  ];
  Widget getPageWidget(String route) {
    switch (route) {
      case '/home':
        return HomeScreen();
      case '/profile':
        return ProfileScreen();
      default:
        return HomeScreen();
    }
  }

  void _changePage(String route) {
    setState(() {
      _currentWidget = getPageWidget(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageRouter(
      goTo: _changePage,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Shared Provider'),
        ),
        drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            AppDrawerHeader(),
            AppDrawerItems(
                routes: routes,
                onChangePage: _changePage,
                getIcon: getIconData),
          ],
        ),
      ),
        body: _currentWidget,
      ),
    );
  }
}




