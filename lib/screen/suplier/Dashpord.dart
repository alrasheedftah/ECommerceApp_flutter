
import 'package:ECommerceTask/model/Order.dart';
import 'package:ECommerceTask/screen/mapWidget.dart';
import 'package:ECommerceTask/screen/suplier/MapScreenAdmin.dart';
import 'package:ECommerceTask/services/Store.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/model.dart';
import '../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Dashpord extends StatefulWidget{

static final String id="Dashpord";
  @override
  State<StatefulWidget> createState() => _Dashpord();

}

class _Dashpord extends State<Dashpord>{
  Store _stor=Store();
  @override
  Widget build(BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  int _quantity =0;
  String _location="LDubai";
    // TODO: implement build
    return Scaffold(

        appBar: AppBar(
          backgroundColor: KBlueAppBar,
          actions: <Widget>[
             Container(
              height: MediaQuery.of(context).size.height ,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Dashoard",//.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color(0xFFFFFAFA)
                    ),
                    ),
                    // Icon(Icons.shopping_cart,
                    // color: Colors.black,
                    // )
                  ],
                ),
              ),
            ),
            ]),

       body: Container(
        //  height: height * .07,
         width: width,
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                      child: Text(
                         "New Order ",
                         style: TextStyle(
                           color: Color(0xFF000000),
                            fontSize: 21,
                            fontWeight: FontWeight.bold
                         ),
                       ),
                    ),
      Container(
        width: width,
        child: mOrderWidget(width, height, _quantity, _location),

//                  ListView(
//                  padding: EdgeInsets.all(10),
//                  children: <Widget>[
//                   //  SizedBox(
//                   //    height: height*.04,
//                   //  ),

//                   SizedBox(
//                     height: height *.01,
//                   ),
//                           // padding: EdgeInsets.all(10),

// Container(
//     // color: Colors.red,
//     width: width,
//     height: height * .2,
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
  
//       children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.only(left: 10),
//                            child: Text("Black Shirt",
//                            style: TextStyle(
//                        color: Color(0xFF707070),
//                         fontSize: 20
//                      ),
//                            ),
//                          ),
  
//             SizedBox(
//               height: height *.01,
//             ),
  
//   Padding(
//     padding: const EdgeInsets.only(left: 40),
//     child:   Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: <Widget>[
    
//        Text("QTY : "+_quantity.toString(),
//         style: TextStyle(
//             fontSize: 20,
//             color: Color(0xFF0A0A0A),
      
//         ),
//       ),
    
//        Row(
//          children: <Widget>[
//            Text("Location: "+_location.toString(),
//             style: TextStyle(
//                 fontSize: 20,
//                 color: Color(0xFF0A0A0A),
      
//             ),
//       ),
//       SizedBox(
//         width: width * .02,
//       ),
//             Text(
//               "View Google Map",
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Color(0xFF707070)
//               ),
//             ),
  
//          ],
//        ),
  
  
//   Padding(
//     padding: const EdgeInsets.symmetric(horizontal: 10),
//     child:   Row(
//       mainAxisAlignment: MainAxisAlignment.start,
//       // crossAxisAlignment: Cro,
//       children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(left: 0,top :5),
//               child: RaisedButton(
                
//                onPressed: (){
//                         },
//                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(45),
//                                side: BorderSide(color: Color(0xFF707070))
//                                   ),
                                          
//                                           color: Color(0xFF0EB707),
//                                           child: Text("Confirm",
                                          
//                                           style: TextStyle(
//                                             color: Colors.white
//                                           ),
                                          
//                                           ),
//                                           padding: EdgeInsets.only(left: 30,right: 30),
//                                         ),
//             ),
    
//             Padding(
//               padding: const EdgeInsets.only(left: 20,top: 5),
//               child: RaisedButton(
//                onPressed: (){
//                         },
//                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(45),
//                                side: BorderSide(color: Color(0xFF707070))
//                                   ),
                                          
//                                           color: Color(0xFFFF0000),
//                                           child: Text("Reject",
                                          
//                                           style: TextStyle(
//                                             color: Color(0xFFFFFFFF)
//                                           ),
                                          
//                                           ),
//                                           padding: EdgeInsets.only(left: 35,right: 35),
//                                         ),
//             ),                                  
//       ],
//     ),
//   ),
  
  
  
//       ],
//     ),
//   ),
  
//       ],
//     ),
//   ),

//    mOrderWidget(width, height, _quantity, _location),
//    mOrderWidget(width, height, _quantity, _location),
//    mOrderWidget(width, height, _quantity, _location),
//    mOrderWidget(width, height, _quantity, _location),
//    mOrderWidget(width, height, _quantity, _location),
//    mOrderWidget(width, height, _quantity, _location),
//    mOrderWidget(width, height, _quantity, _location),

// Column(
//   children: <Widget>[
//                 mOrderWidget(width, height, _quantity, _location),
//   ],
// ),
      //             //  ),
      // ),
      //            ],
      //          ),
        height: height -AppBar().preferredSize.height - MediaQuery.of(context).padding.top -35,//- (height * 0.07),
      ),
//              Container(
//                child: ListView(
//                  padding: EdgeInsets.all(10),
//                  children: <Widget>[
//                   //  SizedBox(
//                   //    height: height*.04,
//                   //  ),

//                   SizedBox(
//                     height: height *.01,
//                   ),
//                           // padding: EdgeInsets.all(10),


// Column(
//   children: <Widget>[
//                 mOrderWidget(width, height, _quantity, _location),
//   ],
// ),

// Container(
//   // color: Colors.red,
//   width: width,
//   height: height * .2,
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,

//     children: <Widget>[
//                                Padding(
//                                  padding: const EdgeInsets.only(left: 10),
//                                  child: Text("White Shirt",
//                                  style: TextStyle(
//                              color: Color(0xFF707070),
//                               fontSize: 20
//                            ),
//                                  ),
//                                ),

//                   SizedBox(
//                     height: height *.01,
//                   ),

// Padding(
//   padding: const EdgeInsets.only(left: 40),
//   child:   Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     mainAxisAlignment: MainAxisAlignment.start,
//     children: <Widget>[
  
//      Text("QTY : "+_quantity.toString(),
//       style: TextStyle(
//                   fontSize: 20,
//                   color: Color(0xFF0A0A0A),
    
//       ),
//     ),
  
//      Row(
//                children: <Widget>[
//                  Text("Location: "+_location.toString(),
//                   style: TextStyle(
//                       fontSize: 20,
//                       color: Color(0xFF0A0A0A),
    
//                   ),
//     ),
//     SizedBox(
//       width: width * .02,
//     ),
//                   Text(
//                     "View Google Map",
//                     style: TextStyle(
//                       fontSize: 15,
//                       color: Color(0xFF707070)
//                     ),
//                   ),

//                ],
//      ),


// Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 10),
//   child:   Row(
//     mainAxisAlignment: MainAxisAlignment.start,
//     // crossAxisAlignment: Cro,
//     children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(left: 0,top :5),
//                     child: RaisedButton(
                      
//                      onPressed: (){
//                               },
//                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(45),
//                                      side: BorderSide(color: Color(0xFF707070))
//                                         ),
                                                
//                                                 color: Color(0xFF0EB707),
//                                                 child: Text("Confirm",
                                                
//                                                 style: TextStyle(
//                                                   color: Colors.white
//                                                 ),
                                                
//                                                 ),
//                                                 padding: EdgeInsets.only(left: 30,right: 30),
//                                               ),
//                   ),
  
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20,top: 5),
//                     child: RaisedButton(
//                      onPressed: (){
//                               },
//                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(45),
//                                      side: BorderSide(color: Color(0xFF707070))
//                                         ),
                                                
//                                                 color: Color(0xFFFF0000),
//                                                 child: Text("Reject",
                                                
//                                                 style: TextStyle(
//                                                   color: Color(0xFFFFFFFF)
//                                                 ),
                                                
//                                                 ),
//                                                 padding: EdgeInsets.only(left: 35,right: 35),
//                                               ),
//                   ),                                  
//     ],
//   ),
// ),



//     ],
//   ),
// ),

//     ],
//   ),
// ),


//                   //  ),

//                  ],
//                ),
//              ),

           ],
         ),
       ),     
    );
  }

   mOrderWidget(double width, double height, int _quantity, String _location,) {
        // List checkOutListWidgets = List<Widget>();
        // for (var product in products) {
        // checkOutListWidgets.add({});   
        // } 
         return StreamBuilder<QuerySnapshot>(
        stream: _stor.loadOrdersDetailsByStream(),
              builder:(context,snapShot)
          { 
            if(snapShot.hasData){
            print(snapShot.data.docs);
            return  ListView(
                 padding: EdgeInsets.all(10),
                    children: snapShot.data.docs.map( (DocumentSnapshot docs) {

                //  children: <Widget>[
                  //  SizedBox(
                  //    height: height*.04,
                  //  ),

                  // SizedBox(
                  //   height: height *.01,
                  // ),
    
    return Container(
    // color: Colors.red,
    width: width,
    height: height * .2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
  
      children: <Widget>[
                         Padding(
                           padding: const EdgeInsets.only(left: 10),
                           child: Text(docs.data()[OrderName]?? "Black Shirt",
                           style: TextStyle(
                       color: Color(0xFF707070),
                        fontSize: 20
                     ),
                           ),
                         ),
  
            SizedBox(
              height: height *.01,
            ),
  
  Padding(
    padding: const EdgeInsets.only(left: 40),
    child:   Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
    
       Text("QTY : "+ docs.data()[OrderQuantity].toString() ?? _quantity.toString(),
        style: TextStyle(
            fontSize: 20,
            color: Color(0xFF0A0A0A),
      
        ),
      ),
    
       Row(
         children: <Widget>[
           Expanded(
             child: AutoSizeText("Location: "+docs.data()[OrderAddress].toString(),
              style: TextStyle(
                  // fontSize: 20,
                  color: Color(0xFF0A0A0A),
              ),
              maxLines: 2,
              presetFontSizes: [20, 15, 10]
      ),
           ),
      // SizedBox(
      //   width: width * .01,
      // ),
            GestureDetector(
              onTap: () {
                Coordinates coordinates=Coordinates(double.parse(docs.data()[OrderLat].toString()),double.parse(docs.data()[OrderLong].toString()));
                Navigator.pushNamed(context, MapScreenAdmin.id,arguments:coordinates);
              },
              child: AutoSizeText(
                "View Google Map",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF707070)
                ),
                maxLines: 9,
                minFontSize: 1,
              ),
            ),
  
         ],
       ),
  
  
  Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child:  docs.data()[OrderStatus]==1? 
                Center(
              // padding: const EdgeInsets.only(left: 0,top :5),
              child: RaisedButton(
                
               onPressed: (){
                  showCustomDialog(Order(
                     pId: docs.id,
                     pName: docs.data()[OrderName],

                  ), context,
                  "Confirm",
                  "Do You want to Confirm This Order ${docs.data()[OrderName]} "
                  );

                        },
                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45),
                               side: BorderSide(color: Color(0xFF707070))
                                  ),
                                          
                                          color: Colors.yellowAccent,//Color(0xFF0EB707),
                                          child: Text("Pinding In the way",
                                          
                                          style: TextStyle(
                                            color: Colors.black
                                          ),
                                          
                                          ),
                                          padding: EdgeInsets.only(left: 30,right: 30),
                                        ),
            ):

     Row(
      mainAxisAlignment: MainAxisAlignment.start,
      // crossAxisAlignment: Cro,
      children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 0,top :5),
              child: RaisedButton(
                
               onPressed: (){
                  showCustomDialog(Order(
                     pId: docs.id,
                     pName: docs.data()[OrderName],

                  ), context,
                  "Confirm",
                  "Do You want to Confirm This Order ${docs.data()[OrderName]} "
                  );

                        },
                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45),
                               side: BorderSide(color: Color(0xFF707070))
                                  ),
                                          
                                          color: Color(0xFF0EB707),
                                          child: Text("Confirm",
                                          
                                          style: TextStyle(
                                            color: Colors.white
                                          ),
                                          
                                          ),
                                          padding: EdgeInsets.only(left: 30,right: 30),
                                        ),
            ),
    
            Padding(
              padding: const EdgeInsets.only(left: 20,top: 5),
              child: RaisedButton(
               onPressed: (){

                  showCustomDialog(Order(
                     pId: docs.id,
                     pName: docs.data()[OrderName],

                  ), context,
                  "Reject",
                  "Do You want to reject This Order ${docs.data()[OrderName]} "
                  );

                        },
                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45),
                               side: BorderSide(color: Color(0xFF707070))
                                  ),
                                          
                                          color: Color(0xFFFF0000),
                                          child: Text("Reject",
                                          
                                          style: TextStyle(
                                            color: Color(0xFFFFFFFF)
                                          ),
                                          
                                          ),
                                          padding: EdgeInsets.only(left: 35,right: 35),
                                        ),
            ),                                  
      ],
    ),
  ),
  
      ],
    ),
  ),
  
      ],
    ),
  );
                    }).toList());
            }else{
              return Center(child: Text("No Order "),);
            }
          });
  }



  void showCustomDialog(Order order,context,title, message ) async{
    var address="";
    AlertDialog alertDialog=AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        MaterialButton(
          onPressed: (){
            try{
              Store _stor=Store();
              if(title == "Reject")
              _stor.deleteOrder(order.pId);
              else
              _stor.editOrder(order,order.pId);
              // _stor.StoreOrder({
              //     OrderAddress :"ombada",
              //     OrderPhone : address
              // }, products);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text("${title}ed "),
              ));
              Navigator.pop(context);
            }catch (ex){
              print(ex.message);
            }
          },
          child: Text("Yes"),
        ),


        MaterialButton(
          onPressed: (){
            try{
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

