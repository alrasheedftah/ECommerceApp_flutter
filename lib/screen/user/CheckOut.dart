

import 'package:ECommerceTask/model/Product.dart';
import 'package:ECommerceTask/provider/CartItem.dart';
import 'package:ECommerceTask/screen/mapWidget.dart';
import 'package:ECommerceTask/screen/suplier/Dashpord.dart';
import 'package:ECommerceTask/screen/suplier/PanelSuplier.dart';
import 'package:ECommerceTask/services/Store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoder/model.dart';

import '../../Home.dart';
import '../../constants.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatefulWidget{
  static final String id="CheckOut";
  @override
  State<StatefulWidget> createState() => _CheckOut();

}


class _CheckOut extends State<CheckOut>{
  int _quantity=0;
  Map<String,int> _quantityList=Map<String,int>();
  Address _location=null;
  @override
  Widget build(BuildContext context) {
  List<Product> products=Provider.of<CarTItem>(context).products;
   double height=MediaQuery.of(context).size.height;
   double width=MediaQuery.of(context).size.width;
    print(products.length);
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                    Text("CheckOut",//.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.black
                    ),
                    ),
                    Icon(Icons.shopping_cart,
                    color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
            ]),

       body: Container(
         child: LayoutBuilder(
           builder:(context,constrains){
             if(products.isEmpty){
               return Center(child:Text("Cart Is Empty To Check Out "));
             }
            return  ListView(
             padding: EdgeInsets.all(20),
             children: <Widget>[
              //  SizedBox(
              //    height: height*.04,
              //  ),

              //  Padding(
                //  padding: EdgeInsets.only(left: 20),
                 Text(
                   "Cart CheckOut",
                   style: TextStyle(
                     color: Color(0xFF000000),
                      fontSize: 21
                   ),
                 ),

               SizedBox(
                 height: height*.04,
               ),
              //  ),
                Text(
                   "Order",
                   style: TextStyle(
                     color: Color(0xFF707070),
                      fontSize: 21
                   ),
                 ),

                 Column(
                   children: 
                     myCheckOutList(width, context,products),

                  //  ],
                 ),
              //  ),
SizedBox(
  height: height * .04,
),          //  ),

              Text(
                   "Add Google Map Loaction",
                   style: TextStyle(
                     color: Color(0xFF707070),
                      fontSize: 20
                   ),
                 ),
            GestureDetector(
              onTap: () async{
            //     Navigator.push(context, 
            // MaterialPageRoute());
            // await Navigator.pushNamed(context, MapScreen.id);
            // int x=0;
            // double y =0.1;
            // x=y as int;
               Address location=await Navigator.pushNamed(context, MapScreen.id) as Address;
               if(location != null){
               await showDialog(context: context,builder: (context) {
                 return AlertDialog(
                   content: Text(location.countryName+location.locality),
                 );

               },);
               setState(() {
                 _location = location;
               });
               }
              },
              child: Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                child: Icon(Icons.add_circle_outline,
                  size: 50,
                  textDirection: TextDirection.rtl,
                ),

              ),
            ),      
            SizedBox(
              height: height*.01,
            ),
            Stack(
              alignment: Alignment.center,
              
              // fit: StackFit.expand,
                children: <Widget>[
                   Image(image: AssetImage('images/pics/maps.jpg'),
                   height: height *.25,
                   fit: BoxFit.fill,
                   ),
                  Text(_location==null?"":_location.countryName+" "+_location.addressLine,
                  style: TextStyle(
                    fontSize: 20,

                  ),
                  )     
                  //  Positioned(
                  //    bottom: 0,
                  //    child: Text("data"))
                ],
            ),

SizedBox(
  height: height * .01,
),

Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
            RaisedButton(
             onPressed: (){
               showCustomDialog(products,context);
                                     },
                               shape: RoundedRectangleBorder(
                                                 borderRadius: BorderRadius.circular(45),
                                            side: BorderSide(color: Color(0xFF707070))
                                               ),
                                                       
                                                       color: Color(0xFFFFC400),
                                                       child: Text("Check Out",
                                                       
                                                       style: TextStyle(
                                                         color: Colors.black87
                                                       ),
                                                       
                                                       ),
                                                       padding: EdgeInsets.only(left: 40,right: 40),
                                                     ),
                 ],
               ),
               
                            ],
                          );
                         }
                        ),
                      ),     
                   );
                 }
               
                 List<Widget> myCheckOutList(double width, BuildContext context,List<Product>products) {
                   List checkOutListWidgets = List<Widget>();
                   for (var product in products) {
                 checkOutListWidgets.add(
                   Padding(
                                  padding: const EdgeInsets.only(left: 20,bottom: 10),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                        Text(product.pName??"Black Shirt",
                                        style: TextStyle(
                                      color: Color(0xFF707070),
                                       fontSize: 20
                                    ),
                                        ),
               SizedBox(
                 width: width *.2,
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
                                                         //  Navigator.pushNamed(context, Dashpord.id);
                                                         add(product);
                                                        },
                                                       child: SizedBox(
                                                         child: Icon(Icons.add_circle_outline,size: 30,
                                                         ),
                                                          height: 28,
                                                          width: 28,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 20,right: 20),
                                                    child: Text(
                                                       product.quantity.toString(),
                                                       style: TextStyle(
                                                         fontSize: 32
                                                       ),
                                                    ),
                                                  ),
                                                  ClipOval(
                                                  child: Material(
                                                      color: MainColor,
                                                    child: GestureDetector(
                                                        onTap: (){
                                                         //  Navigator.pushNamed(context, PanelSuplier.id);
                                                         subtract(product);
                                                         if(product.quantity == 0)
                                                           Provider.of<CarTItem>(context,listen: false).deleteProduct(product);
                                                        },
                                                       child: SizedBox(
                                                         child: Icon(Icons.remove_circle_outline),
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
                                      )
                                    ],
                                  ),
                                )
                 );
                   print(checkOutListWidgets.length);
               }
                 return checkOutListWidgets;
               
               //     return Padding(
               //                    padding: const EdgeInsets.only(left: 20,bottom: 10),
               //                    child: Column(
               //                      children: <Widget>[
               //                        Row(
               //                          children: <Widget>[
               //                          Text("Black Shirt",
               //                          style: TextStyle(
               //                        color: Color(0xFF707070),
               //                         fontSize: 20
               //                      ),
               //                          ),
               // SizedBox(
               //   width: width *.2,
               // ),
               //                         Padding(
               //                            padding: const EdgeInsets.only(top: 5),
               //                                   child: Row(
               //                                crossAxisAlignment: CrossAxisAlignment.center,
               //                                mainAxisAlignment: MainAxisAlignment.center,
               //                                children: <Widget>[
               //                                    ClipOval(
               //                                    child: Material(
               //                                        color: MainColor,
               //                                      child: GestureDetector(
               //                                          onTap: (){
               //                                            Navigator.pushNamed(context, Dashpord.id);
               //                                          },
               //                                         child: SizedBox(
               //                                           child: Icon(Icons.add_circle_outline,size: 30,
               //                                           ),
               //                                            height: 28,
               //                                            width: 28,
               //                                          ),
               //                                        ),
               //                                      ),
               //                                    ),
               //                                    Padding(
               //                                      padding: const EdgeInsets.only(left: 20,right: 20),
               //                                      child: Text(
               //                                         _quantity.toString(),
               //                                         style: TextStyle(
               //                                           fontSize: 32
               //                                         ),
               //                                      ),
               //                                    ),
               //                                    ClipOval(
               //                                    child: Material(
               //                                        color: MainColor,
               //                                      child: GestureDetector(
               //                                          onTap: (){
               //                                            Navigator.pushNamed(context, PanelSuplier.id);
               //                                          },
               //                                         child: SizedBox(
               //                                           child: Icon(Icons.remove_circle_outline),
               //                                            height: 28,
               //                                            width: 28,
               //                                          ),
               //                                        ),
               //                                      ),
               //                                    ),
               //                                ]                             
               //                                   ),
               //                                 ),
               
               //                          ],
               //                        )
               //                      ],
               //                    ),
               //                  );
                 }
               
                     void subtract(Product product) {
                       
                       if(product.quantity > 0)
                           setState(() {
                           product.quantity--;
                           });
               
                     }
               
                     void add(Product product) {
                       if(product.quantity <= 9)
                       setState(() {
                        product.quantity++;
                       });
                       print(product.quantity);
                     }
               
  void showCustomDialog(List<Product> products,context) async{
    var address="";
    AlertDialog alertDialog=null;
    if(_location ==null){
    alertDialog=AlertDialog(
      title: Text("Warring"),
      content: Text(" Please Add Location Your for \nDistenation Address "),

    );

    }
    else
    alertDialog=AlertDialog(
      title: Text("You Want To Copmlete \n Checkout  ${products.length} Products"),
      content: TextField(
        onChanged: (value) => address=value,
        decoration: InputDecoration(
          hintText: "Enter Your Phone ",
        ),
        keyboardType: TextInputType.phone,
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: (){
            try{

              Store _stor=Store();
              _stor.StoreOrder({
                  OrderAddress :_location.addressLine,
                  OrderPhone : address,
                  OrderLong:_location.coordinates.longitude,
                  OrderLat:_location.coordinates.latitude,

              }, products);
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(" Ordered Done "),
              ));
              Navigator.pop(context);
            }catch (ex){
              print(ex.message);
            }
          },
          child: Text("Confirm"),
        ),
      ],
    );

  await  showDialog(context: context,builder: (context){
      return alertDialog; 
    });
  }


}