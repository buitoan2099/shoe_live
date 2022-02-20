import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shoe_live/bloc/product.dart';
import 'package:shoe_live/model/shoe.dart';
import 'package:shoe_live/service/local.dart';

import 'cart.dart';

class Data {
  static late ProductBloc productBloc;
  static Future<List<Shoe>> getProductData() async {
    List<Shoe> shoes = [];
    final  data1 = await Local.getShoes();
    if(data1.length!=0){
      return data1;
    }else{
      final String response = await rootBundle.loadString('assets/shoes.json');
      final data = await jsonDecode(response);
      for(var i in data['shoes'])
        shoes.add(Shoe.fromJson(i));
      return shoes;
    }

  }
  static Future<List<Cart>> getCartData() async {
    final  data1 = await Local.getCarts();
    return data1;
  }
}
