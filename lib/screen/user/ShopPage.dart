
import 'dart:convert';

import 'package:ECommerceTask/local/LocalStorage.dart';
import 'package:ECommerceTask/model/MyUser.dart';
import 'package:ECommerceTask/model/Product.dart';
import 'package:ECommerceTask/model/Story.dart';
import 'package:ECommerceTask/screen/StoryViewScreen.dart';
import 'package:ECommerceTask/screen/suplier/Dashpord.dart';
import 'package:ECommerceTask/screen/suplier/PanelSuplier.dart';
import 'package:ECommerceTask/screen/user/CheckOut.dart';
import 'package:ECommerceTask/services/DBStorage.dart';
import 'package:provider/provider.dart';
import 'package:ECommerceTask/Home.dart';
import 'package:ECommerceTask/constants.dart';
import 'package:ECommerceTask/provider/CartItem.dart';
import 'package:ECommerceTask/services/Store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShopPage extends StatefulWidget{
  static final String id="ShopPage";
  @override
  State<StatefulWidget> createState() => _ShopPage();

}


class _ShopPage extends State<ShopPage>{
  Store _stor=Store();
  int _quantity=0;
  int _quantityColors=0;

  Map<String,int> _quantityList=Map<String,int>();

  @override
  Widget build(BuildContext context) {
    // User currentUser=FirebaseAuth.instance.currentUser;
    MyUser usr=MyUser(
      MyUserEmail: "currentUser.email",
      MyUserId: "ID User ",
      MyUserName: "Name",
      MyUserImage: "emage",
    );
    print(jsonEncode(usr));
    
    print(MyUser.fromJson(jsonDecode(jsonEncode(usr))).MyUserEmail+"ana");

  double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
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
                    Text("Shop",//.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black
                    ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, CheckOut.id);
                      },
                      child: Icon(Icons.shopping_cart,
                      color: _quantityColors > 0 ? Colors.blue: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
            ]),

            body: Container(
              child: ListView(              
                  children: <Widget>[
                  SizedBox(
                      height: MediaQuery.of(context).size.height * .04,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Story",
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
                    child: getStoryListView(),
                  ),
                //  myStoryWidget(),
                SizedBox(
                   height: height*.04, 
                ),
                GestureDetector(
                  onTap: (){
                    showCustomMenu();
                  },
                  child: Container(
                    // width: MediaQuery.of(context).size.width*.4,
                    height: height*.4,
                    // color: Colors.red,
                    child: myCustomCard(height, context, _quantity),
                    // child: ListView(
                    //   scrollDirection: Axis.horizontal,
                    //   children: <Widget>[
                    //     // Text("aaaaa"),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width*.5,
                    //       height: height*.3,
                    //       child: myCustomCard(height, context, _quantity),
                    //     ),
                    //                           Container(
                    //       width: MediaQuery.of(context).size.width*.5,
                    //       height: height*.3,
                    //       child: myCustomCard(height, context, _quantity),
                    //     ),
                    //                           Container(
                    //       width: MediaQuery.of(context).size.width*.5,
                    //       height: height*.3,
                    //       child: myCustomCard(height, context, _quantity),
                    //     )
                    //   ],
                    // ),
                  ),
                )  ,
                SizedBox(
                  height: height*.01,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          // Navigator.pushNamed(context, PanelSuplier.id);
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 15,
                        ),
                      ),
                      SizedBox(
                        width:  MediaQuery.of(context).size.width *.05,
                      ),
                      GestureDetector(
                        onTap: (){
                          // Navigator.pushNamed(context, Dashpord.id);
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFD0D0D0),
                          radius: 15,
                        ),
                      ),
                      SizedBox(
                        width:  MediaQuery.of(context).size.width *.05,
                      ),                      
                      GestureDetector(
                        onTap: (){
                          // Navigator.pushNamed(context, Home.id);
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xFFFFC400),
                          radius: 15,
                        ),
                      ),                                            
                    ],
                  ),
                ),
                  ],
              ),
            ),

            );
  }

 getStoryListView()  {
   LocalStorage _localStorage=LocalStorage();
   List<MyUser>_usersStoryList=[];
   DBStorage dbStorage=DBStorage();
  //  Map<String,List<String>  storyModel=Map();
    return StreamBuilder<QuerySnapshot>(
        stream: _stor.loadUserByStream(),
              builder:(context,snapShot)
          { 
            if(snapShot.hasData) {
            print(snapShot.data.docs);
            _usersStoryList=[];
            for(var docs in snapShot.data.docs){
                 _localStorage.storeUserList(docs.id, MyUser(
                  MyUserEmail: docs.data()[MyUserEmail],
                  MyUserImage: docs.data()[MyUserImage],
                  MyUserName: docs.data()[MyUserName],
                  MyUserId: docs.data()[MyUserId]
                )); 
                _usersStoryList.add(MyUser(
                  MyUserEmail: docs.data()[MyUserEmail],
                  MyUserImage: docs.data()[MyUserImage],
                  MyUserName: docs.data()[MyUserName],
                  MyUserId: docs.data()[MyUserId]
                ));
            }

              return ListView(
                    scrollDirection: Axis.horizontal,
                    children: _usersStoryList.map( (MyUser docs) {
                      // print(dbStorage.getUrlImage(docs.data()[StoryImage]));
                      // storyModel[docs.data()[StoryName]]=docs.data()[StoryName];
                  return  Padding(
                     padding: const EdgeInsets.only(top: 0,left: 20),
                    //  child: Expanded(
                         child: GestureDetector(
                           onTap: () {
                             
                             Navigator.pushNamed(context, StoryViewScreen.id,arguments: docs.MyUserId);
                           },
                           child: Stack(
                             alignment: const Alignment(0.6, 0),
                             children: <Widget>[
                               Container(
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(100),
                                   border: Border.all(width: 2,color: Colors.blue)
                                 ),
                                 child: CircleAvatar (
                                   backgroundColor: Colors.blue,
                                   radius: 35,
                                   
                                   backgroundImage:NetworkImage(docs.MyUserImage),//??AssetImage("images/story/ana.jpg",
                        //  height: MediaQuery.of(context).size.height * 0.1,
                                  //  ),

                                 ),
                               ),
                               Container(
                                 decoration: BoxDecoration(
                                   color: Colors.black12,
                                 ),
                                 child: Text(
                                   docs.MyUserEmail.toUpperCase().substring(0,1)??"M".toUpperCase().substring(0,1),
                                   style: TextStyle(
                                     fontSize: 20,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.black
                                   ),
                                 ),
                               )
                             ],
                           ),
                         ),
                        //  flex: 1,
                      //  ),
                   );
                  //  Padding(
                  //    padding: const EdgeInsets.only(left: 20,top: 0),
                  //   //  child: Expanded(
                  //        child: Stack(
                  //          alignment: const Alignment(0.6, 0),
                  //          children: <Widget>[
                  //            Container(
                  //              decoration: BoxDecoration(
                  //                borderRadius: BorderRadius.circular(100),
                  //                border: Border.all(width: 2,color: Colors.white)
                  //              ),
                  //              child: CircleAvatar(
                  //                backgroundColor: Colors.blue,
                  //                radius: 35,
                  //                backgroundImage: AssetImage("images/story/ana.jpg",
                  //       //  height: MediaQuery.of(context).size.height * 0.1,
                  //                ),

                  //              ),
                  //            ),
                  //            Container(
                  //              decoration: BoxDecoration(
                  //                color: Colors.black12,
                  //              ),
                  //              child: Text(
                  //                "M",
                  //                style: TextStyle(
                  //                  fontSize: 20,
                  //                  fontWeight: FontWeight.bold,
                  //                  color: Colors.black
                  //                ),
                  //              ),
                  //            )
                  //          ],
                  //        ),
                  //       //  flex: 1,
                  //     //  ),
                  //  ),

                    }).toList(),
                  );

            }
        else{
          return Center(child: Text("Loading....."));
        }

  });
  }

myCustomCard(double height, BuildContext context, int _quantity) {
    return StreamBuilder<QuerySnapshot>(
        stream: _stor.loadProductByStream(),
              builder:(context,snapShot)
          { 
            if(snapShot.hasData){
            print(snapShot.data.docs);
            return  ListView(
                    scrollDirection: Axis.horizontal,
                    children: snapShot.data.docs.map( (DocumentSnapshot docs) {
                            if(_quantityList[docs.id]==null)
                            _quantityList[docs.id]=0;
                  return
                      // Text("aaaaa"),
                      Container(
                        width: MediaQuery.of(context).size.width*.5,
                        height: height*.3,
                        child: Card(
                        borderOnForeground: true,
                        elevation: 2,
                        clipBehavior: Clip.antiAlias,
                        shadowColor: Colors.yellow,
                        // color: Colors.black,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Image(image: NetworkImage(docs.data()[ProductLocation]??'images/story/ana.jpg'),
                              height: height*0.20,
                              width: MediaQuery.of(context).size.width*.5,
                              ),
                            ),
                            SizedBox(
                              height: height*.02,
                            ),
                            Text(docs.data()[ProductName] ??"Black Shirt",
                            style: TextStyle(
                              color: Color(0x9C707070),
                              fontSize: 20
                            ),
                            ),
                           SizedBox(
                              height: height*.02,
                            ),
                            RaisedButton(
                              onPressed: (){
                                  CarTItem carTItem=Provider.of<CarTItem>(context,listen: false);
                                  var exsit=0;
                                  var products =carTItem.products;
                                  for(var productInCart in products){
                                  if(productInCart.pId == docs.id){
                                    productInCart.quantity=_quantityList[docs.id];
                                    exsit=1;
                                  }
                                  }
                                  if(exsit ==0 ){
                                  if(_quantityList[docs.id] >0){  
                                  carTItem.addProduct(Product(
                                     pName: docs.data()[ProductName],
                                     pCategory: docs.data()[ProductCategories],
                                     pLocation: docs.data()[ProductLocation],
                                     pPrice: docs.data()[ProductPrice].toString()+"",
                                     quantity: _quantityList[docs.id],
                                     pId: docs.id,
                                     pUserId: docs.data()[ProductUserId] 
                                  ));
                                  setState(() {
                                  _quantityColors=_quantityColors+1;  
                                  });                                  
                                  print("Quantity "+_quantityColors.toString());

                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Add To Cart "),
                                  ));
                                  }
                                  else
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Cannot Add To Cart Quantity Is 0"),
                                  ));  
                                  }
                                  else{
                                  if(_quantityList[docs.id] >0){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Already Added To Cart "),
                                  ));                                    
                                  }else
                                  {
                                      Provider.of<CarTItem>(context,listen: false).deleteProductById(
                                        Product(
                                     pName: docs.data()[ProductName],
                                     pCategory: docs.data()[ProductCategories],
                                     pLocation: docs.data()[ProductLocation],
                                     pPrice: docs.data()[ProductPrice].toString()+"",
                                     quantity: _quantityList[docs.id],
                                     pId: docs.id,
                                  )
                                      );
                                      setState(() {
                                  _quantityColors=_quantityColors-1;  
                                      });
                                  print("Quantity "+_quantityColors.toString());

                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text("Removed  From Cart"),
                                  ));                                    

                                  }                                    
                                  }
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                                side: BorderSide(color: Color(0xFF707070))
                              ),
                              color: Color(0xFFFFC400),
                              child: Text("Buy",
                              style: TextStyle(
                                color: Colors.black87
                              ),
                              ),
                              padding: EdgeInsets.all(5),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                               ClipOval(
                               child: Material(
                                   color: MainColor,
                                 child: GestureDetector(
                                     onTap: (){
                                       add(docs.id);
                                                                            },
                                                                           child: SizedBox(
                                                                             child: Icon(Icons.add,size: 30,),
                                                                              height: 28,
                                                                              width: 28,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.only(left: 20,right: 20),
                                                                        child: Text(
                                                                           _quantityList[docs.id].toString()??"0",
                                                                           style: TextStyle(
                                                                             fontSize: 30
                                                                           ),
                                                                        ),
                                                                      ),
                                                                      ClipOval(
                                                                      child: Material(
                                                                          color: MainColor,
                                                                        child: GestureDetector(
                                                                            onTap: (){
                                                                              subtract(docs.id);
                                                                            },
                                                                           child: SizedBox(
                                                                             child: Icon(Icons.remove),
                                                                              height: 28,
                                                                              width: 28,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                  ]                             
                                                                     ),
                                                                   ),
                                                                 ],
                                                               ),
                                                             ));
                                                           }).toList());
                                                   }
                                                   else{
                                                     return Center(child: Text("loading....."),);
                                                   }
                                                 });
                                         }
                                       
      void subtract(id) {
        
        if(_quantityList[id] > 0)
            setState(() {
            _quantityList[id]--;
            });
      }

      void add(id) {
        setState(() {
        _quantityList[id]++;
        });
        print(_quantityList[id]);
      }

  void showCustomMenu() {
    
  }

}