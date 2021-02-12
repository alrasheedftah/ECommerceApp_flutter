

import 'package:ECommerceTask/model/Product.dart';
import 'package:flutter/cupertino.dart';

class CarTItem extends ChangeNotifier{

  List<Product> products= [];

  addProduct(Product product){
    products.add(product);
    notifyListeners();
  }

  deleteProduct(Product product){
    products.remove(product);
    notifyListeners();
  }


  deleteProductById(Product product){
    products.remove(
     products.firstWhere((element) => element.pId == product.pId));
    notifyListeners();
  }

  refreshProducts(productsRefresh){
    products.clear();
    products=productsRefresh;
    notifyListeners();
  }
}