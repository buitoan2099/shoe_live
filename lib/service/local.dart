import 'package:shared_preferences/shared_preferences.dart';
import 'package:shoe_live/model/cart.dart';
import 'package:shoe_live/model/shoe.dart';

class Local{
  static Future<List<Cart>> getCarts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Cart.decode(prefs.getString('carts')??'');
  }
  static Future<List<Shoe>> getShoes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Shoe.decode(prefs.getString('shoes')??'');
  }

  static void saveData({required List<Cart> carts,required List<Shoe> shoes}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('carts', Cart.encode(carts));
    await prefs.setString('shoes', Shoe.encode(shoes));

  }
}