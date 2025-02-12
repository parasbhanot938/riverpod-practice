import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_demo/search/product_model.dart';

class ProductNotifier extends Notifier<List<Product>>{

  List<Product> productList=[
    Product(name: "Laptops",),
    Product(name: "TVs",),
    Product(name: "Phones",),
    Product(name: "Fans",),
    Product(name: "ACs",),
    Product(name: "Mouse",),
  ];


  @override
  List<Product> build() {

    return productList;

  }



  filterProduct({required String query}){

    debugPrint("query ${query}");


    if(query==null || query==""){
       state=productList;
    }
    else{
 state=
      productList.where((element) {
        return element.name.toLowerCase().contains(query.toLowerCase());
      },).toList();

    }

  }


}
