import 'dart:convert';

import 'shoe.dart';

class Cart{
  int amount;
  Shoe? info;

  Cart({
    this.info,
    this.amount = 1,
  });

  Cart.fromJson(Map<String, dynamic> json)
      : amount = json['amount'] ?? 0,
        info = Shoe.fromJson(json['info'] ?? '');


  static Map<String, dynamic> toJson(Cart cart) => {
    'amount': cart.amount,
    'info': Shoe.toJson(cart.info??Shoe()),

  };
  static String encode(List<Cart> carts) => jsonEncode(
    carts
        .map<Map<String, dynamic>>((cart) => Cart.toJson(cart))
        .toList(),
  );

  static List<Cart> decode(String carts) {
    if(carts==""){
      return [];
    }else{
      return (json.decode(carts) as List<dynamic>)
          .map<Cart>((item) => Cart.fromJson(item))
          .toList();
    }
  }


}
