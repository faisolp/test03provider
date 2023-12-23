import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyModel(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MyHomePage(),
      ),
    );
  }
}

class MyModel with ChangeNotifier {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared AppBar'),
      ),
      body: Navigator(
        onGenerateRoute: _generateRoute,
      ),
    );
  }

  Route<dynamic> _generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case '/':
        builder = (BuildContext _) => FirstScreen();
        break;
      case '/second':
        builder = (BuildContext _) => SecondScreen();
        break;
      default:
        builder = (BuildContext _) => FirstScreen(); // Default to FirstScreen
        break;
    }
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<MyModel>(
            builder: (context, myModel, child) {
              return Text('Counter: ${myModel.counter}');
            },
          ),
          ElevatedButton(
            child: Text('Increment'),
            onPressed: () => Provider.of<MyModel>(context, listen: false).increment(),
          ),
          ElevatedButton(
            child: Text('Go to Second Screen'),
            onPressed: () {
              Navigator.of(context).pushNamed('/second');
            },
          ),
        ],
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer<MyModel>(
            builder: (context, myModel, child) {
              return Text('Counter: ${myModel.counter}');
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
