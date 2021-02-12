import 'package:ECommerceTask/model/MyUser.dart';
import 'package:ECommerceTask/model/Product.dart';
import 'package:ECommerceTask/model/Story.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Store{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  addProduct(Product product){
       _firestore.collection(ProductCollection).add({
         ProductName : product.pName,
         ProductDescription : product.pDescription,
         ProductPrice : product.pPrice,
         ProductCollection : product.pLocation,
         ProductCategories : product.pCategory
       });
       
  }

  Future<List<Product>> loadProduct() async{
    List<Product> products=[];
   var snapShot= await FirebaseFirestore.instance.collection(ProductCollection).get();

    for(var data in snapShot.docs){
      var doc=data.data();
            products.add(Product(
            pName: doc[ProductName],
            pPrice: doc[ProductPrice],
            pCategory: doc[ProductCategories],
            pDescription: doc[ProductDescription],
            pLocation: doc[ProductLocation]         )); 
    }

    
  //  List<Product> products 
    //  snapShot
    //  .then((QuerySnapshot querySnapshot) => {
    //    querySnapshot.docs.forEach((doc) {
    //       products.add(Product(
    //         pName: doc[ProductName],
    //         pPrice: doc[ProductPrice],
    //         pCategory: doc[ProductCategories],
    //         pDescription: doc[ProductDescription],
    //         pLocation: doc[ProductLocation]          
    //       ));
    //    })
    //  });
    return products;   
  }

   Stream<QuerySnapshot> loadProductByStream() {
      return  _firestore.collection(ProductCollection).snapshots();
    }

     Stream<QuerySnapshot> loadCategoriesByStream() {
      return  _firestore.collection(CategoryCollection).snapshots();
    }


    deleteProduct(documentId){
      _firestore.collection(ProductCollection).doc(documentId).delete();
    }

  editProduct(data,documentId){
    _firestore.collection(ProductCollection).doc(documentId).update(data);
  }


     Stream<QuerySnapshot> loadStoryByStream(userId) {
      return  _firestore.collection(MyUserCollection).doc(userId).collection(StoryCollection).snapshots();
    }


     Stream<QuerySnapshot> loadUserByStream() {
      return  _firestore.collection(MyUserCollection).snapshots();
    }

  StoreOrder(data,List<Product> products){
    var documentRef= _firestore.collection(OrderCollection).doc();
    documentRef.set(data);
    for( var product in products){
    documentRef.collection(OrderDetails).doc().set({
      ProductName : product.pName,
      ProductQuantity : product.quantity,
      // OrderAddress : data.OrderAddress
    
    });
    _firestore.collection(OrderDetails).add({
      OrderName : product.pName,
      OrderQuantity : product.quantity,
      OrderAddress : data['Address'],
      OrderStatus : 0,
      OrderUserID :product.pUserId,
      OrderLat:data[OrderLat],
      OrderLong:data[OrderLong],
    });
    // print(data['Address']);
    }
    // _firestore.collection(OrderCollection).add(data);
  }

  Stream<QuerySnapshot> loadOrdersByStream() {
      return  _firestore.collection(OrderCollection).snapshots();
    }


  Stream<QuerySnapshot> loadOrdersDetailsByStream() {
    String user_id=FirebaseAuth.instance.currentUser.uid;
      return  _firestore.collection(OrderDetails).where('user_id',isEqualTo: user_id).snapshots();
    }


    deleteOrder(documentId){
      _firestore.collection(OrderDetails).doc(documentId).delete();
    }

  editOrder(data,documentId){
    _firestore.collection(OrderDetails).doc(documentId).update({
      OrderStatus : 1
    });
  }

  addStory(StoryModel story) async{
      User user= FirebaseAuth.instance.currentUser;
    
    var documentUser= await _firestore.collection(MyUserCollection)
    .where("id",isEqualTo: user.uid).limit(1).get();
    var documentRef=_firestore.collection(MyUserCollection).doc(user.uid);//documentUser.docs[0].data()['id']);
    // .where("id",isEqualTo:user.uid)
    // .limit(1)
    // .get().then((value){
    // });

    await   documentRef.collection(StoryCollection).add({
          MyStoryName : story.sName,
          MyStoryImage : story.sImage,
          MyStoryTime : DateTime.now(),
          MyStoryCaption : story.sCaption,
          MyStoryType : story.sType,
       });

  await documentRef.update({MyUserImage : story.sImage});
       
  }

  addUserData(MyUser myUser){
       _firestore.collection(MyUserCollection).doc(myUser.MyUserId).set({
         MyUserImage:'https://firebasestorage.googleapis.com/v0/b/ecomerce-e656b.appspot.com/o/story%2F1607258218025.jpg?alt=media&token=d6f3bce3-362c-48fe-be49-9487f27224ca',
         MyUserId : myUser.MyUserId,
         MyUserEmail : myUser.MyUserEmail
       });
  }


} 