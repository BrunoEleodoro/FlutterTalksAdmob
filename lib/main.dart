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

  BannerAd myBanner;
  InterstitialAd myInterstitial;
  int clicks = 0;

  void startBanner() {
    myBanner = BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.smartBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.opened) {
          // MobileAdEvent.opened
          // MobileAdEvent.clicked
          // MobileAdEvent.closed
          // MobileAdEvent.failedToLoad
          // MobileAdEvent.impression
          // MobileAdEvent.leftApplication
        }
        print("BannerAd event is $event");
      },
    );
  }

  void displayBanner() {
    myBanner
      ..load()
      ..show(
        anchorOffset: 0.0,
        anchorType: AnchorType.bottom,
      );
  }

  @override
  void dispose() {
    myBanner?.dispose();
    myInterstitial?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-3940256099942544~3347511713");

    startBanner();
    displayBanner();
  }

  InterstitialAd buildInterstitial() {
    return InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        targetingInfo: MobileAdTargetingInfo(testDevices: <String>[]),
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            myInterstitial?.show();
          }
          if (event == MobileAdEvent.clicked || event == MobileAdEvent.closed) {
            myInterstitial.dispose();
            clicks = 0;
          }
        });
  }

  void onTap(position) {
    shouldDisplayTheAd();
    if (position == 0) {
      Navigator.pushNamed(context, '/first');
    } else {
      Navigator.pushNamed(context, '/second');
    }
  }

  void shouldDisplayTheAd() {
    clicks++;
    if (clicks >= 3) {
      myInterstitial = buildInterstitial()
        ..load()
        ..show();
      clicks = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Scaffold(
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
        ));
  }
}
