import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'pages/first_screen.dart';
import 'pages/second_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        '/first': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
      },
    );
  }
}

//ca-app-pub-3940256099942544~3347511713
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: <String>[],
  );

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-3940256099942544~3347511713");
  }

  void onTap(position) {
    if (position == 0) {
      Navigator.pushNamed(context, '/first');
    } else {
      Navigator.pushNamed(context, '/second');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: Center(
          child: Text(
            'Home Page',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: this.onTap,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            title: Text('First Screen'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_balance_wallet),
              title: Text('Second Screen')),
        ],
      ),
    );
  }
}
