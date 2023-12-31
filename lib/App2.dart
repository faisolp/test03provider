import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'providers/userprofile.provider.dart';
import 'tools/UI.tool.dart';


void main() {
  runApp(MyApp());
}

/*class MyApp extends StatelessWidget {
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
}*/

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return ProfileProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
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
class PageRouter extends InheritedWidget {
  final Function(String) goTo;
  final Widget child;

  PageRouter({Key? key, required this.goTo, required this.child}) : super(key: key, child: child);

  static PageRouter? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<PageRouter>();
  }

  @override
  bool updateShouldNotify(PageRouter oldWidget) {
    return goTo != oldWidget.goTo;
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
        'Drawer Header',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}

class AppDrawerItems extends StatelessWidget {
  final List<Map<String, dynamic>> routes;
  final Function(String) onChangePage;
  final Function(String) getIcon;

  AppDrawerItems({required this.routes, required this.onChangePage, required this.getIcon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: routes.map((route) => DrawerItem(
            title: route['title'],
            iconData: getIcon(route['icon']),
            onTap: () => onChangePage(route['route']),
          )).toList(),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback onTap;

  DrawerItem({required this.title, required this.iconData, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
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
              PageRouter.of(context)?.goTo('/profile');
 
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
              PageRouter.of(context)?.goTo('/home');
            },
          ),
        ],
      ),
    );
  }
}



