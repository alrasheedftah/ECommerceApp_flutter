
import 'package:ECommerceTask/screen/SinginScreen.dart';
import 'package:ECommerceTask/screen/user/CheckOut.dart';
import 'package:ECommerceTask/screen/user/ShopPage.dart';
import 'package:ECommerceTask/services/Auth.dart';
import 'package:ECommerceTask/services/Store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'constants.dart';

class Home extends StatefulWidget
{
  static final String id="HomePage";
 
  @override
  _Home createState() =>
    // TODO: implement createState
    _Home();
}


class _Home extends State<Home>{
  final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();
  int _tabBarIndex=0,_bottomNavBar=0;
  bool _logoutSwitch=true;
  Store _stor=Store();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
      key: _globalKey,
      endDrawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(child:Container(
              color: Color(0x5F0000FF),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Text("ECommetce App")
              ],),
            )),
            new ListTile(
              leading: new Icon(Icons.notification_important,),
              trailing: new Switch(value: _logoutSwitch,onChanged: (value) {
                setState(() {
                  _logoutSwitch=value;
                });
              },
              activeColor: Colors.blueAccent,
              activeTrackColor: Colors.blueAccent,
              ),
              title: new Text("Notification"),
              subtitle: new Text("Accept Notfy "),
              
              onTap: (){},
            ),
              new ListTile(
              leading: new Icon(Icons.add_business),
              trailing: new Switch(value: true,onChanged: null,),
              title: new Text("Adds"),
              subtitle: new Text("Show External Adds "),
              onTap: (){},  
            ),

             new ListTile(
              leading: new Icon(Icons.shopping_cart),
              title: new Text("Shop"),
              subtitle: new Text("Shop Some Products"),
              onTap: (){
                Navigator.pushNamed(context, ShopPage.id);
              },
             ),
              new ListTile(
              leading: new Icon(Icons.person_add_disabled_sharp),
              title: new Text("Logout"),
              subtitle: new Text("logout From App"),
              onTap: (){
                  showCustomDialog();
              },
              
            ),


            new AboutListTile(
              aboutBoxChildren: <Widget>[
                new Text("Ecommerce Apps By Flutter Design @Alrasheed")
              ],
              icon: new Icon(Icons.info),
              child: new Text("about app"),)
          ],
        ),
      ),


        appBar: AppBar(
          backgroundColor: MainColor,
          actions: <Widget>[
             Container(
              height: MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Categories",//.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black
                    ),
                    ),
                    GestureDetector(
                      onTap: (){
                        print("Drware");
                        _globalKey.currentState.openEndDrawer();
                      },
                      child: Icon(Icons.menu,
                      color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ]),

      body: VerticalTabs(
  tabsWidth: 100,
  tabs: <Tab>[
    Tab(
      child: myTabBar(context,"images/icons/womenFashion.png","Mobiles &\n Accessories")//
      ),
    Tab(
      child: myTabBar(context,"images/icons/menFashion.png","Women\'s \nFashion")
      ),
    Tab(
      child: myTabBar(context,"images/icons/KidsFashion.png","Men\'s \nFashion")
      ),
    Tab(
      child: myTabBar(context,"images/icons/watch.png","Kid\'s \nFashion")
      ),
    Tab(
      child: myTabBar(context,"images/icons/farniture.png","Furniture")
      ),

  ],
  contents: <Widget>[
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: buildCustomPageListView(context,1),
    ),
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: buildCustomPageListView(context,2),
    ),
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: buildCustomPageListView(context,3),
    ),
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: buildCustomPageListView(context,4),
    ),
        Padding(
      padding: const EdgeInsets.all(8.0),
      child: buildCustomPageListView(context,5),
    ),
    // Container(child: Text('Dart'), padding: EdgeInsets.all(20)),
    // Container(child: Text('NodeJS'), padding: EdgeInsets.all(20)),
    // Container(child: Text('PHP'), padding: EdgeInsets.all(20)),
    // Container(child: Text('HTML 5'), padding: EdgeInsets.all(20))
  ],
),
    );
  }

  ListView buildCustomPageListView(BuildContext context,deptId) {
    return ListView(
      children: <Widget>[
        Text('Men\'s Fashion',
          style: TextStyle(
            color: Color(0xFF000000),
            fontSize: 17,
            
          ),
        ),
                Container(
                  alignment: Alignment.topLeft,
                  // color: Colors.red,
                  width: MediaQuery.of(context).size.width*.67,
                  height: MediaQuery.of(context).size.height*.13,
                  child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                        child:Stack(
                          children: <Widget>[
                            Image(image: AssetImage("images/story/ana.jpg"),width: MediaQuery.of(context).size.width,fit: BoxFit.fill,),
                          ],
                        ),
                  ),
                ),
            SizedBox(
              // height: MediaQuery.of(context).size.height*0.01,
            ),
            myHomeViewPadding(context,'top',deptId),
      
        Text(
          "Top \n Categories",
          style: TextStyle(
            color: Color(0xFF000000),

          ),
          maxLines: 1,
        ),

                    myHomeViewPadding(context,'top',deptId),


        Text(
          "Other \n Categories",
          style: TextStyle(
            color: Color(0xFF000000),

          ),
          maxLines: 1,
        ),

            myHomeViewPadding(context,'other',deptId),

            // Padding(
            //   padding: const EdgeInsets.only(top: 10),
            //   child: Container(
            //     height: MediaQuery.of(context).size.height*.12,
            //     width: MediaQuery.of(context).size.width*.1,
            //     alignment: Alignment.topLeft,
            //           // color: Colors.red,
            //           child: Row(
            //             children: <Widget>[
            //               Padding(
            //                     padding: EdgeInsets.fromLTRB(0, 1, 0, 6),
            //                     child:Column(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       children: <Widget>[
            //                         Image(image: AssetImage("images/story/ana.jpg"),
            //                         height: MediaQuery.of(context).size.height *.08,
            //                         width: MediaQuery.of(context).size.width *.21,
            //                         ),
            //                         Text("Clearance",
            //                         style: TextStyle(
            //                           color: Color(0xFF000000),
            //                           fontSize: 15
            //                         ),
            //                         )
            //                       ],
            //                     ),
            //               ),

            //               GestureDetector(
            //                 onTap: (){
            //                   Navigator.pushNamed(context, CheckOut.id);
            //                 },
            //                 child: Padding(
            //                       padding: EdgeInsets.fromLTRB(0, 1, 0, 10),
            //                       child:Column(
            //                         mainAxisAlignment: MainAxisAlignment.start,
            //                         children: <Widget>[
            //                           Image(image: AssetImage("images/story/ana.jpg"),
            //                           height: MediaQuery.of(context).size.height *.08,
            //                           width: MediaQuery.of(context).size.width *.21,
            //                           ),
            //                           Text("Clearance",
            //                           style: TextStyle(
            //                             color: Color(0xFF000000),
            //                             fontSize: 15
            //                           ),
            //                           )
            //                         ],
            //                       ),
            //                 ),
            //               ),
            //             ],

            //           ),
                      
                    
            //         ),
            // ),



      ],
    );
  }

   myHomeViewPadding(BuildContext context,classification,deptdId) {

    return StreamBuilder<QuerySnapshot>(
              stream: _stor.loadCategoriesByStream(),
              builder:(context,snapShot)
          { 
            if(snapShot.hasData){
            return  Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height*.15,
                  width: MediaQuery.of(context).size.width*.1,
                  alignment: Alignment.topLeft,
                        // color: Colors.red,
                        child: GridView(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          children: snapShot.data.docs.map( (DocumentSnapshot docs) {
                            if(docs.data()[CategoryClassification]==classification && docs.data()[CategoryDeptID] == deptdId)
                          return    Padding(
                                  padding: EdgeInsets.fromLTRB(0, 1, 0, 1),
                                  child:Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Image(image:  NetworkImage(docs.data()[CategoryImage]),//AssetImage("images/story/ana.jpg"),//
                                        height: MediaQuery.of(context).size.height *.08,
                                        width: MediaQuery.of(context).size.width *.21,
                                        ),
                                        Text( CategoryName ?? "Clearance",
                                        style: TextStyle(
                                          color: Color(0xFF000000),
                                          fontSize: 15
                                        ),
                                        )
                                      ],
                                    ),
                                  ),
                            );
                          }).toList()
                          //   Padding(
                          //         padding: EdgeInsets.fromLTRB(0, 1, 0, 10),
                          //         child:Column(
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           children: <Widget>[
                          //             Image(image: AssetImage("images/story/ana.jpg"),
                          //             height: MediaQuery.of(context).size.height *.08,
                          //             width: MediaQuery.of(context).size.width *.21,
                          //             ),
                          //             Text("Clearance",
                          //             style: TextStyle(
                          //               color: Color(0xFF000000),
                          //               fontSize: 15
                          //             ),
                          //             )
                          //           ],
                          //         ),
                          //   ),

                          //   Padding(
                          //         padding: EdgeInsets.fromLTRB(0, 1, 0, 10),
                          //         child:Column(
                          //           mainAxisAlignment: MainAxisAlignment.start,
                          //           children: <Widget>[
                          //             Image(image: AssetImage("images/story/ana.jpg"),
                          //             height: MediaQuery.of(context).size.height *.08,
                          //             width: MediaQuery.of(context).size.width *.21,
                          //             ),
                          //             Text("Clearance",
                          //             style: TextStyle(
                          //               color: Color(0xFF000000),
                          //               fontSize: 15
                          //             ),
                          //             )
                          //           ],
                          //         ),
                          //   ),

                          // ],
                        ),
                      
                      ),
              );
            }
            else{
          return Center(child: Text("Loading....."));
            }
          }
    );
  }

  Container myTabBar(BuildContext context,String icons,String text) {
    return Container(
      // alignment: Alig,
      height: MediaQuery.of(context).size.height*.18,
      child: Padding(
        padding: const EdgeInsets.only(left: 20,top: 5,bottom: 10),
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            //  Icon(Icons.phone_android,size: 50,),
            Image(image: AssetImage(icons,),width: 60,height: 40,),
             Positioned(
               left: 2,
               bottom: 40,
               child: Text(
                 text,
                 style: TextStyle(
                   color: Color(0xFF000000),
                   fontSize: 13,
                   
                 ),
                 maxLines: 2,
               ),
             ),
          ],
        ),
      ),
    );
  }


    void showCustomDialog() async{
      Auth _auth=Auth();
    AlertDialog alertDialog=AlertDialog(
      title: Text("Logout"),
      content: Text("Do You Want Logout "),
      actions: <Widget>[
        MaterialButton(
          onPressed: (){
            try{
              _auth.logout();
              Navigator.pushNamedAndRemoveUntil(context, SinginScreen.id ,(route) => false);
            }catch (ex){
              print(ex.message);
            }
          },
          child: Text("Yes"),
        ),


        MaterialButton(
          onPressed: (){
            try{
              print(_auth.getCurrentUser().toString()+" email");
              Navigator.pop(context);
            }catch (ex){
              print(ex.message);
            }
          },
          child: Text("No"),
        ),        
      ],
    );

  await  showDialog(context: context,builder: (context){
      return alertDialog; 
    });
  }


}