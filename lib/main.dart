import 'package:ECommerceTask/provider/CartItem.dart';
import 'package:ECommerceTask/provider/ModelHud.dart';
import 'package:ECommerceTask/screen/SignupScreen.dart';
import 'package:ECommerceTask/screen/SinginScreen.dart';
import 'package:ECommerceTask/screen/SplashScreen.dart';
import 'package:ECommerceTask/screen/StoryViewScreen.dart';
import 'package:ECommerceTask/screen/mapWidget.dart';
import 'package:ECommerceTask/screen/suplier/Dashpord.dart';
import 'package:ECommerceTask/screen/suplier/MapScreenAdmin.dart';
import 'package:ECommerceTask/screen/suplier/PanelSuplier.dart';
import 'package:ECommerceTask/screen/user/CheckOut.dart';
import 'package:ECommerceTask/screen/user/ShopPage.dart';
import 'package:ECommerceTask/services/Auth.dart';
import 'package:flutter/material.dart';

import 'Home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ECommerceTask/screen/suplier/MapScreenAdmin.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _MyApp();

}

class _MyApp extends State<MyApp>{
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }

// }
// class MyApp extends StatelessWidget {
  
Auth auth=Auth();
User user=null;
bool isAdmin=false;
SharedPreferences preferences;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAwaitAdmin();
    getCurrentUser();
    print("is ADmin init "+isAdmin.toString());
    
  }

getAwaitAdmin(){
    isAdminOrNot();
}
  isAdminOrNot() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
    isAdmin=  prefs.getBool('isAdmin');
    print("is ADmin set "+isAdmin.toString());
    });
    // print("isAdmin"+isAdmin.toString());
    return isAdmin; //prefs.getBool('isAdmin');
  }

  
  getCurrentUser() {
    User userData= FirebaseAuth.instance.currentUser;
    setState(() {
      user=userData;
    });
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // getCurrentUser();
    // isAdminOrNot();
    print(user!=null?user.email.toLowerCase():"anaRasta");
    print("isAdminBuild  "+(isAdmin!=true).toString() );
    return MultiProvider(
      providers: [
            ChangeNotifierProvider<ModelHud>(
              create : (context) => ModelHud(),),
            ChangeNotifierProvider<CarTItem>(
              create : (context) => CarTItem(),),

      ],
          child: MaterialApp(
            
            initialRoute:user == null? SinginScreen.id : Splash.id,//(!isAdmin? Home.id: PanelSuplier.id),
            routes: {
              MapScreen.id :(context) => MapScreen(),
              StoryViewScreen.id :(context) => StoryViewScreen(),
              Home.id : (context)=> Home(),
              ShopPage.id : (context) => ShopPage(),
              SinginScreen.id : (context)=>SinginScreen(),
              SignupScreen.id :(context) => SignupScreen(),
              CheckOut.id : (context)=>CheckOut(),
              Dashpord.id : (context) => Dashpord(),
              PanelSuplier.id : (context)=>PanelSuplier(),
              Splash.id : (context)=>Splash(),
              MapScreenAdmin.id :(context)=>MapScreenAdmin(),
            },
      ),
    );
  }
}
