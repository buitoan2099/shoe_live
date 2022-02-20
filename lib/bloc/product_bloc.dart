
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_live/model/cart.dart';
import 'package:shoe_live/model/data.dart';
import 'package:shoe_live/model/shoe.dart';
import 'package:shoe_live/service/local.dart';

import 'product.dart';


class ProductBloc extends Bloc<ProductEvent, ProductState> {


  get contextPage => null;
  ProductBloc(ProductState initialState, BuildContext contextPage) : super(initialState)  {
    on<GetData>((event, emit) async {
      final List<Cart> carts = await Data.getCartData();
      final List<Shoe> shoes = await Data.getProductData();
      double cost = 0;
      for(var c in carts){
        cost=cost+c.info!.price*c.amount;
      }
      print("f");
      emit(GetProductSucState(carts: carts,shoes: shoes, cost: double.parse(cost.toStringAsFixed(2))));
    });
    on<AddCartEvent>((event, emit) async {
      state.shoes[event.vt].isChoice = true;

      final double cost = double.parse((state.cost! + state.shoes[event.vt].price).toStringAsFixed(2));

      state.carts.add(Cart(info: state.shoes[event.vt]));
      Local.saveData(carts: state.carts,shoes: state.shoes,);
      emit(ProductState.getValue(state,carts: state.carts,shoes: state.shoes, cost: double.parse(cost.toStringAsFixed(2))));
    });
    on<DelCartEvent>((event, emit) async {
      for(int  i =0 ;i<state.shoes.length;i++){
        if(state.shoes[i].id==state.carts[event.vt].info!.id){
          state.shoes[i].isChoice = false;
        }
      }
      final double cost = state.cost! - state.carts[event.vt].info!.price*state.carts[event.vt].amount;

      state.carts.removeAt(event.vt);
      Local.saveData(carts: state.carts,shoes: state.shoes,);

      emit(ProductState.getValue(state,carts: state.carts,shoes: state.shoes, cost: double.parse(cost.toStringAsFixed(2))));
    });
    on<AddAmountEvent>((event, emit) async {
      final double cost = state.cost! + state.carts[event.vt].info!.price;
      state.carts[event.vt].amount++;
      Local.saveData(carts: state.carts,shoes: state.shoes,);

      emit(ProductState.getValue(state,carts: state.carts,cost: double.parse(cost.toStringAsFixed(2))));
    });
    on<SubAmountEvent>((event, emit) async {
      final double cost = state.cost! - state.carts[event.vt].info!.price;
      state.carts[event.vt].amount--;
      if(state.carts[event.vt].amount==0) Data.productBloc.add(DelCartEvent(vt: event.vt));

      else {
        Local.saveData(carts: state.carts,shoes: state.shoes,);

        emit(ProductState.getValue(state,carts: state.carts,cost: double.parse(cost.toStringAsFixed(2))));
      }
    });

  }
}