import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoe_live/bloc/product.dart';
import 'package:shoe_live/model/data.dart';
import 'package:shoe_live/util/colors.dart';
import 'package:shoe_live/util/convert_data.dart';
import 'package:shoe_live/util/textForm.dart';
import 'package:shoe_live/model/cart.dart';
import 'dart:math' as math;

class CartWidget extends StatelessWidget{
  final List<Cart> carts;
  final double? cost;
  final ScrollController controller;
  CartWidget({Key? key,required this.carts,required this.cost,required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    const String s = "\$";
    // TODO: implement build
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Image.asset(
            'assets/images/nike.png',
            width: 55,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15,),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextForm.textSel(
                  'Your cart',
                  style: TextStyle(
                    fontFamily: 'VariableFont_wght',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: AppColors.black,
                  ),
                ),
                TextForm.textSel(
                  '$s'+cost.toString(),
                  style: TextStyle(
                    fontFamily: 'VariableFont_wght',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: (carts.isEmpty)?Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextForm.textSel(
                "Your cart is empty",
                style: TextStyle(
                  fontFamily: 'VariableFont_wght',
                  fontWeight: FontWeight.w200,
                  fontSize: 14,
                  color: AppColors.black,
                ),
              ),
            ):
            NotificationListener<OverscrollNotification>(
              onNotification: (OverscrollNotification value) {
                if (value.overscroll < 0 && controller.offset + value.overscroll <= 0) {
                  if (controller.offset != 0) controller.jumpTo(0);
                  return true;
                }
                if (controller.offset + value.overscroll >= controller.position.maxScrollExtent) {
                  if (controller.offset != controller.position.maxScrollExtent) controller.jumpTo(controller.position.maxScrollExtent);
                  return true;
                }
                controller.jumpTo(controller.offset + value.overscroll);
                return true;
              },
              child: ListView.builder(
                itemCount: carts.length,
                itemBuilder: (BuildContext context, int i) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child:  Transform.translate(
                          offset: Offset(-10,-10),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: ConvertData.convertColor(carts[i].info!.color),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: AppColors.gray.withOpacity(0.1),
                                      blurRadius: 15,
                                      offset: const Offset(10, 12),
                                    ),
                                  ],
                                  shape: BoxShape.circle,
                                ),
                                width: 100,
                                height: 90,
                                alignment: Alignment.centerLeft,
                              ),
                              Container(
                                height: 140,
                                alignment: Alignment.center,
                                child: Transform.translate(
                                  offset: Offset(0,0),
                                  child: Transform.rotate(
                                    angle: -math.pi/4*25/45,
                                    child: Image.network(carts[i].info!.image,width: 200,height: 200,fit: BoxFit.cover,),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        flex: 2,
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        flex: 3,
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextForm.textSel(
                                carts[i].info!.name,
                                style: TextStyle(
                                  fontFamily: 'VariableFont_wght',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.black,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: TextForm.textSel(
                                  '$s'+carts[i].info!.price.toString(),
                                  style: TextStyle(
                                    fontFamily: 'VariableFont_wght',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 22,
                                    color: AppColors.black,
                                  ),
                                ),

                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 30,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Data.productBloc.add(SubAmountEvent(vt: i));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: AppColors.white.withOpacity(0.6),
                                                shape: CircleBorder(),
                                              ), child: Text(""),

                                            ),
                                          ),
                                          Image.asset(
                                            'assets/images/minus.png',
                                            width: 8,
                                          ),
                                        ],
                                      ),

                                      Container(
                                        width: 40,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                        child: TextForm.textSel(
                                          carts[i].amount.toString(),
                                          style: TextStyle(
                                            fontFamily: 'VariableFont_wght',
                                            fontWeight: FontWeight.w200,
                                            fontSize: 15,
                                            color: AppColors.black,
                                          ),
                                        ),

                                      ),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Container(
                                            width: 30,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Data.productBloc.add(AddAmountEvent(vt: i));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: AppColors.white.withOpacity(0.6),
                                                shape: CircleBorder(),
                                              ), child: Text(""),

                                            ),
                                          ),
                                          Image.asset(
                                            'assets/images/plus.png',
                                            width: 8,
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: AppColors.yellow,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Material(
                                      borderRadius: BorderRadius.all(Radius.circular(36)),
                                      color:  Colors.white.withOpacity(0.0),
                                      child:InkWell(
                                        borderRadius: BorderRadius.circular(25.0),
                                        splashColor: Colors.white.withOpacity(0.1),
                                        onTap: (){
                                          Data.productBloc.add(DelCartEvent(vt: i));
                                        },
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Container(

                                            ),
                                            Image.asset(
                                              'assets/images/trash.png',
                                              width: 15,
                                              color: AppColors.black,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  );
                },
              ),
            ),

          ),
        ],
      ),
    );
  }

}