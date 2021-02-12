
import 'package:ECommerceTask/model/MyUser.dart';
import 'package:ECommerceTask/model/Product.dart';
import 'package:ECommerceTask/screen/StoryViewScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';
import 'package:ECommerceTask/model/Story.dart';
import 'package:ECommerceTask/screen/SinginScreen.dart';
import 'package:ECommerceTask/screen/suplier/Dashpord.dart';
import 'package:ECommerceTask/services/Auth.dart';
import 'package:ECommerceTask/services/DBStorage.dart';
import 'package:ECommerceTask/services/Store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Home.dart';
import '../../constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class PanelSuplier extends StatefulWidget{

static final String id="PanelSuplier";
  @override
  State<StatefulWidget> createState() => _PanelSuplier();

}

class _PanelSuplier extends State<PanelSuplier>{
  int _quantity=0;
  File _image;
  Store _stor=Store();
    bool _logoutSwitch=true;
  final picker = ImagePicker();
  final GlobalKey<ScaffoldState> _globalKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(

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
              leading: new Icon(Icons.shopping_bag),
              title: new Text("Orders"),
              subtitle: new Text("Order Managements"),
              onTap: (){
                Navigator.pushNamed(context, Dashpord.id);
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
  backgroundColor: KBlueAppBar,
  title:  Text("Panel",//.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFFFFFAFA)
                    ),
                    ),
),
        // appBar: AppBar(
        //   backgroundColor: KBlueAppBar,
        //   actions: <Widget>[
        //      Container(
        //       height: MediaQuery.of(context).size.height ,
        //       width: MediaQuery.of(context).size.width,
        //       child: Padding(
        //         padding: const EdgeInsets.fromLTRB(30, 10, 20, 20),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: <Widget>[
        //             Text("Panel",//.toUpperCase(),
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 24,
        //               color: Color(0xFFFFFAFA)
        //             ),
        //             ),
        //             // Icon(Icons.shopping_cart,
        //             // color: Colors.black,
        //             // )
        //           ],
        //         ),
        //       ),
        //     ),
        //     ]),

             body: Container(
              child: ListView(              
                  children: <Widget>[
                  SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Add Story",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF707070),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .01,
                    ),
                  Container(
                    // color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*.15,
                    child: buildCustomStoryView(context),
                  ),
                //  myStoryWidget(),
                SizedBox(
                   height: height*.01, 
                ),

                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Add Prodcut",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF707070),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * .01,
                    // ),
                  Container(
                    // color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*.1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                     Padding(
                       padding: const EdgeInsets.only(top: 0,left: 20),
                      //  child: Expanded(
                           child: Stack(
                             alignment: const Alignment(0.6, 0),
                             children: <Widget>[
                               Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(100),
                                  //  border: Border.all(width: 2,color: Colors.blue)
                                 ),
                                 child: CircleAvatar(
                                   backgroundColor: MainColor,
                                   radius: 35,
                                  //  backgroundImage: AssetImage("images/story/ana.jpg",
                          //  height: MediaQuery.of(context).size.height * 0.1,
                                  //  ),
                                  // backgroundImage: Icon(),
                                  child: Icon(Icons.add_circle_outline,size: 50,),
                                  foregroundColor: Colors.black,                  
                                 ),
                               ),
                             ],
                           ),
                          //  flex: 1,
                        //  ),
                     ),
                     Padding(
                       padding: const EdgeInsets.only(top: 0,left: 20),
                     ),
                      ],
                    ),
                  ),

                // Container(
                //   alignment: Alignment.topLeft,
                //   // width: MediaQuery.of(context).size.width*.4,
                //   height: height*.4,
                //   width: MediaQuery.of(context).size.width*.01,
                //   // color: Colors.red,
                //   color: Colors.red,
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Container(
                       height: height-(height*.1) - (height*.15)-height*.07-(AppBar().preferredSize.height),
                       child: buildCustomProductsListView(height, context),
                     ),
                   ),
          SizedBox(
            height: height * .01,
          ),

                  ],
              ),
            ),

            );
  }

  buildCustomProductsListView(double height, BuildContext context) {
   List<Product> _products=[];
    User userData= FirebaseAuth.instance.currentUser;
  return  StreamBuilder<QuerySnapshot>(
        stream: _stor.loadProductByStream(),
              builder:(context,snapShot)
          { 
    print("builStoryBeforif");

            if(snapShot.hasData) {
   _products=[];
for(var docs in snapShot.data.docs){
 if(docs.data()[ProductUserId] == userData.uid) 
_products.add(Product(
    pName: docs.data()[ProductName],
    pImage1: docs.data()['image1'],
    pImage2: docs.data()['image2'],
    pImage3: docs.data()['image3']
));
}
    return ListView.builder(
      itemCount: _products.length,
      itemBuilder: (context, index) {
        return    Column(
                           
                           children: <Widget>[
                             Text(
                              _products[index].pName??"Defualt Name",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xFF000000),
                              ),
                            ),
                             Container(
                               height: height * .4,
                               child: ListView(
                                 padding: EdgeInsets.all(10),
                                 scrollDirection: Axis.horizontal,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // scrollDirection: Axis.horizontal,
                                children: <Widget>[
                                    if(_products[index].pImage1 != null)
                                    myImageProduct(height, context,Colors.black,_products[index].pImage1),
                                    if(_products[index].pImage2 != null)
                                    myImageProduct(height, context,Color(0xFFD0D0D0),_products[index].pImage2),
                                    if(_products[index].pImage3 != null)
                                    myImageProduct(height, context,Color(0xFFFFC400),_products[index].pImage3),

                                ],
                ),
                             ),
                           ],
                         );

      },

              //                               Column(
              //        mainAxisAlignment: MainAxisAlignment.start,
              //        children: <Widget>[
              //          Text(
              //           "Black Shirt",
              //           style: TextStyle(
              //             fontSize: 18,
              //             color: Color(0xFF000000),
              //           ),
              //         ),
              //          Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //           // scrollDirection: Axis.horizontal,
              //           children: <Widget>[
              //               myImageProduct(height, context,Colors.black),
              //           ],
              //   ),
              //        ],
              //      ),
              // // )  ,

                     );

                 }else{
                   return Center( child:Text("You Hav Not Product "));
                 }
          });
                
  }

   buildCustomStoryView(BuildContext context) {
    var _addButtonFlag=-1;
    User userData= FirebaseAuth.instance.currentUser;
  return  StreamBuilder<QuerySnapshot>(
        stream: _stor.loadUserByStream(),
              builder:(context,snapShot)
          { 
    print("builStoryBeforif");

            if(snapShot.hasData) {
    List<MyUser> _usersStoryList=[];
            print(snapShot.data.docs);
    print("builStoryHasData");
    _usersStoryList.add(MyUser(
      MyUserId: null
    ));
        for(var docs in snapShot.data.docs){
        // snapShot.data.docs.map( (DocumentSnapshot docs){
          print("docsMaps");
          _usersStoryList.add(
            MyUser(
              MyUserId: docs.data()[MyUserId],
              MyUserImage: docs.data()[MyUserImage],
              MyUserEmail: docs.data()[MyUserEmail]
            )
                //  Padding(
                //      padding: const EdgeInsets.only(top: 0,left: 20),
                //     //  child: Expanded(
                //          child: Stack(
                //            alignment: const Alignment(0.6, 0),
                //            children: <Widget>[
                //              GestureDetector(
                //                onTap: (){

                //                  //TODO 
                //                  getImage();

                //                },
                //                child: Container(
                //                  decoration: BoxDecoration(
                //                    borderRadius: BorderRadius.circular(100),
                //                   //  border: Border.all(width: 2,color: Colors.blue)
                //                  ),
                //                  child: CircleAvatar(
                //                    backgroundColor: MainColor,
                //                    radius: 35,
                //                   //  backgroundImage: AssetImage("images/story/ana.jpg",
                //         //  height: MediaQuery.of(context).size.height * 0.1,
                //                   //  ),
                //                   // backgroundImage: Icon(),
                //                   child: Icon(Icons.add_circle_outline,size: 50,),
                //                   foregroundColor: Colors.black,                  
                //                  ),
                //                ),
                //              ),
                //            ],
                //          ),
                //         //  flex: 1,
                //       //  ),
                //    )
          );

        }
                return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _usersStoryList.length,
                    itemBuilder: (context,index){
                    if(index >0)  
                    return Padding(
                     padding: const EdgeInsets.only(top: 0,left: 20),
                    //  child: Expanded(
                         child: Stack(
                           alignment: const Alignment(0.6, 0),
                           children: <Widget>[
                             GestureDetector(
                               onTap: () {
                             Navigator.pushNamed(context, StoryViewScreen.id,arguments: _usersStoryList[index].MyUserId);
                               },
                               child: Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(100),
                                   border: Border.all(width: 2,color: Colors.blue)
                                 ),
                                 child: CircleAvatar(
                                   backgroundColor: Colors.blue,
                                   radius: 35,
                                   backgroundImage: _image!=null && _usersStoryList[index].MyUserId == userData.uid? FileImage(_image) : NetworkImage(_usersStoryList[index].MyUserImage,//AssetImage("images/story/ana.jpg",
                        //  height: MediaQuery.of(context).size.height * 0.1,
                                   ),

                                 ),
                               ),
                             ),
                             Container(
                               decoration: BoxDecoration(
                                 color: Colors.black12,
                               ),
                               child: Text(
                                 "M",
                                 style: TextStyle(
                                   fontSize: 20,
                                   fontWeight: FontWeight.bold,
                                   color: Colors.black
                                 ),
                               ),
                             )
                           ],
                         ),
                        //  flex: 1,
                      //  ),
                   );

                  else return     Padding(
                     padding: const EdgeInsets.only(top: 0,left: 20),
                    //  child: Expanded(
                         child: Stack(
                           alignment: const Alignment(0.6, 0),
                           children: <Widget>[
                             GestureDetector(
                               onTap: (){

                                 //TODO 
                                 getImage();

                               },
                               child: Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(100),
                                  //  border: Border.all(width: 2,color: Colors.blue)
                                 ),
                                 child: CircleAvatar(
                                   backgroundColor: MainColor,
                                   radius: 35,
                                  //  backgroundImage: AssetImage("images/story/ana.jpg",
                        //  height: MediaQuery.of(context).size.height * 0.1,
                                  //  ),
                                  // backgroundImage: Icon(),
                                  child: Icon(Icons.add_circle_outline,size: 50,),
                                  foregroundColor: Colors.black,                  
                                 ),
                               ),
                             ),
                           ],
                         ),
                        //  flex: 1,
                      //  ),
                   );


                    },
            //         children: snapShot.data.docs.map( (DocumentSnapshot docs){
            //           _addButtonFlag++;
            //           print(_addButtonFlag.toString());
            // if(_addButtonFlag <=0)
            // return     Padding(
            //          padding: const EdgeInsets.only(top: 0,left: 20),
            //         //  child: Expanded(
            //              child: Stack(
            //                alignment: const Alignment(0.6, 0),
            //                children: <Widget>[
            //                  GestureDetector(
            //                    onTap: (){

            //                      //TODO 
            //                      getImage();

            //                    },
            //                    child: Container(
            //                      decoration: BoxDecoration(
            //                        borderRadius: BorderRadius.circular(100),
            //                       //  border: Border.all(width: 2,color: Colors.blue)
            //                      ),
            //                      child: CircleAvatar(
            //                        backgroundColor: MainColor,
            //                        radius: 35,
            //                       //  backgroundImage: AssetImage("images/story/ana.jpg",
            //             //  height: MediaQuery.of(context).size.height * 0.1,
            //                       //  ),
            //                       // backgroundImage: Icon(),
            //                       child: Icon(Icons.add_circle_outline,size: 50,),
            //                       foregroundColor: Colors.black,                  
            //                      ),
            //                    ),
            //                  ),
            //                ],
            //              ),
            //             //  flex: 1,
            //           //  ),
            //        );
            //       //  Padding(
            //       //    padding: const EdgeInsets.only(top: 0,left: 20),
            //       //   //  child: Expanded(
            //       //        child: Stack(
            //       //          alignment: const Alignment(0.6, 0),
            //       //          children: <Widget>[
            //       //            Container(
            //       //              decoration: BoxDecoration(
            //       //                borderRadius: BorderRadius.circular(100),
            //       //                border: Border.all(width: 2,color: Colors.blue)
            //       //              ),
            //       //              child: CircleAvatar(
            //       //                backgroundColor: Colors.blue,
            //       //                radius: 35,
            //       //                backgroundImage: _image!=null ? FileImage(_image) : AssetImage("images/story/ana.jpg",
            //       //       //  height: MediaQuery.of(context).size.height * 0.1,
            //       //                ),

            //       //              ),
            //       //            ),
            //       //            Container(
            //       //              decoration: BoxDecoration(
            //       //                color: Colors.black12,
            //       //              ),
            //       //              child: Text(
            //       //                "M",
            //       //                style: TextStyle(
            //       //                  fontSize: 20,
            //       //                  fontWeight: FontWeight.bold,
            //       //                  color: Colors.black
            //       //                ),
            //       //              ),
            //       //            )
            //       //          ],
            //       //        ),
            //       //       //  flex: 1,
            //       //     //  ),
            //       //  )
            //       //  ]:
            //       return Padding(
            //          padding: const EdgeInsets.only(top: 0,left: 20),
            //         //  child: Expanded(
            //              child: Stack(
            //                alignment: const Alignment(0.6, 0),
            //                children: <Widget>[
            //                  Container(
            //                    decoration: BoxDecoration(
            //                      borderRadius: BorderRadius.circular(100),
            //                      border: Border.all(width: 2,color: Colors.blue)
            //                    ),
            //                    child: CircleAvatar(
            //                      backgroundColor: Colors.blue,
            //                      radius: 35,
            //                      backgroundImage: _image!=null ? FileImage(_image) : AssetImage("images/story/ana.jpg",
            //             //  height: MediaQuery.of(context).size.height * 0.1,
            //                      ),

            //                    ),
            //                  ),
            //                  Container(
            //                    decoration: BoxDecoration(
            //                      color: Colors.black12,
            //                    ),
            //                    child: Text(
            //                      "M",
            //                      style: TextStyle(
            //                        fontSize: 20,
            //                        fontWeight: FontWeight.bold,
            //                        color: Colors.black
            //                      ),
            //                    ),
            //                  )
            //                ],
            //              ),
            //             //  flex: 1,
            //           //  ),
            //        );
            //         }).toList()
                  );
            
            }else{
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(top: 0,left: 20),
                    //  child: Expanded(
                         child: Stack(
                           alignment: const Alignment(0.6, 0),
                           children: <Widget>[
                             GestureDetector(
                               onTap: (){

                                 //TODO 
                                 getImage();

                               },
                               child: Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(100),
                                  //  border: Border.all(width: 2,color: Colors.blue)
                                 ),
                                 child: CircleAvatar(
                                   backgroundColor: MainColor,
                                   radius: 35,
                                  //  backgroundImage: AssetImage("images/story/ana.jpg",
                        //  height: MediaQuery.of(context).size.height * 0.1,
                                  //  ),
                                  // backgroundImage: Icon(),
                                  child: Icon(Icons.add_circle_outline,size: 50,),
                                  foregroundColor: Colors.black,                  
                                 ),
                               ),
                             ),
                           ],
                         ),
                        //  flex: 1,
                      //  ),
                   )]
                  );

            }
          });
  }

  Container myImageProduct(double height, BuildContext context,Color mycolor,imageProduct) {
    return Container(
                        alignment: Alignment.topLeft,
                        // color: Colors.blue,
                        height: height * .27,
                        width: MediaQuery.of(context).size.width *.3,
                        // child: Card(
                        //   shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(15)
                        //   ),
                           child: Padding(
                             padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.start,
                               children: <Widget>[
                          ClipRRect(
                              child: Image(image: NetworkImage(imageProduct) ??AssetImage('images/story/ana.jpg'),
                              height: height * .20,
                              fit: BoxFit.fitHeight,
                              width: MediaQuery.of(context).size.width * .3,
                              ),
                              borderRadius: BorderRadius.circular(15),
                              
                          ) ,
                    SizedBox(
                      height: height * .01,
                    ),      
                    CircleAvatar(
                      backgroundColor: mycolor,
                      radius: 15,
                    ),
                      
                               
                               ],
                             ),
                           ),
                        // ),
                      );
  }


  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        DBStorage dbStorage=DBStorage();
        dbStorage.uploadFile(_image,"ana");
      } else {
        print('No image selected.');
      }
    });
  }


// Future<void> uploadFile(String filePath) async {
//   File file = File(filePath);

//   try {
//     firebase_storage.UploadTask  task=  firebase_storage.FirebaseStorage.instance
//         .ref('uploads/file-to-upload.png')
//         .putFile(_image);
//         await task;
//         print(await task.snapshot.ref.fullPath);
//         Store _stor=Store();
//         _stor.addStory(StoryModel(
//           sName: "ana",
//           sImage: task.snapshot.ref.fullPath,
          
//         ));
//         // .snapshot.ref.;
//         print("true");
//   }  catch (e) {
//     print(e);
//     // e.g, e.code == 'canceled'
//   }
// }



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

