import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'tools/UI.tool.dart';

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

class ProfileProvider with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _navigateTo(String routeName) {
    _navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (route) => false);
  }
  final List<Map<String, String>> routes = [
    {'route': '/home', 'title': 'Home', 'icon': 'home'},
    {'route': '/profile', 'title': 'Profile', 'icon': 'person'},
    // เพิ่ม routes อื่นๆ ที่นี่
  ];
  Route<dynamic> _generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case '/':
        builder = (BuildContext _) => HomeScreen();
        break;
      case '/profile':
        builder = (BuildContext _) => ProfileScreen();
        break;
      default:
        builder = (BuildContext _) => HomeScreen(); // Default to HomeScreen
        break;
    }
    return MaterialPageRoute(builder: builder, settings: settings);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared AppBar'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            AppDrawerHeader(),
            AppDrawerItems(
              routes: routes,
              onItemTap: (route) {
                Navigator.of(context).pop(); // Close the drawer
                _navigateTo(route);
              },
            ),
          ],
        ),
      ),
      body: Navigator(
        key: _navigatorKey,
        onGenerateRoute: _generateRoute,
      ),
    );
  }

  }
class AppDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: Text(
        'Navigation Menu',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}

class AppDrawerItems extends StatelessWidget {
  final List<Map<String, String>> routes;
  final Function(String) onItemTap;

  AppDrawerItems({required this.routes, required this.onItemTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: routes.map((routeInfo) {
        return AppDrawerItem(
          title: routeInfo['title']!,
          route: routeInfo['route']!,
          icon: getIconData(routeInfo['icon']!),
          onTap: () => onItemTap(routeInfo['route']!),
        );
      }).toList(),
    );
  }
}

class AppDrawerItem extends StatelessWidget {
  final String title;
  final String route;
  final IconData icon;
  final VoidCallback onTap;

  AppDrawerItem({required this.title, required this.route, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
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
              Navigator.of(context).pushNamed('/profile');
            },
          ),
        ],
      ),
    );
  }
}

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
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
