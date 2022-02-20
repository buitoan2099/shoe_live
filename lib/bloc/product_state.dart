import 'package:shoe_live/model/cart.dart';
import 'package:shoe_live/model/shoe.dart';

class ProductState {
  final List<Cart> carts;
  final List<Shoe> shoes;
  double? cost;
  ProductState({required this.carts,required this.shoes,this.cost});

  static ProductState getValue(ProductState oldValue,{
    List<Cart>? carts,
    List<Shoe>? shoes,
    double? cost,
  }){
    return ProductState(
      carts: carts??oldValue.carts,
      shoes: shoes??oldValue.shoes,
      cost: cost??oldValue.cost,
    );
  }}

//Employee

class InitProductState extends ProductState {
  InitProductState() : super(cost: 0,carts: [],shoes: []);
}

class GetProductSucState extends ProductState {
  final List<Cart> carts;
  final List<Shoe> shoes;
  double? cost;

  GetProductSucState({required this.carts,required this.shoes,required this.cost})
      : super(carts: carts,shoes: shoes,cost: cost);

}
//
// class GetEmployeeFailState extends ProductState {}
//
// class EmptyProductState extends ProductState {}
//
// class ChoiceProductState extends ProductState {}


