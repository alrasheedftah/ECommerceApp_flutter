import 'package:ECommerceTask/Home.dart';
import 'package:ECommerceTask/screen/suplier/PanelSuplier.dart';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  static final String id="Splash";
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isAdmin = (prefs.getBool('isAdmin') ?? false);

    if (isAdmin) {
    print("IsSplash "+isAdmin.toString());
      Navigator.of(context).pushReplacementNamed(PanelSuplier.id);
         
    } else {
    print("NOtSplash "+isAdmin.toString());

      // await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacementNamed(Home.id);
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    print("Splash");
    return new Scaffold(
      body: new Center(
        child: new Text('Loading...'),
      ),
    );
  }
}