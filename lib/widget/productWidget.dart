import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoe_live/bloc/product.dart';
import 'package:shoe_live/model/data.dart';
import 'package:shoe_live/util/colors.dart';
import 'package:shoe_live/util/convert_data.dart';
import 'package:shoe_live/util/textForm.dart';
import 'package:shoe_live/model/shoe.dart';
import 'dart:math' as math;

class ProductWidget extends StatelessWidget{
  final ScrollController controller;

  final List<Shoe> shoes;
  ProductWidget({Key? key,required this.shoes,required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            child: TextForm.textSel(
              'Our Products',
              style: TextStyle(
                fontFamily: 'VariableFont_wght',
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: AppColors.black,
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<OverscrollNotification>(
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
                itemCount: shoes.length,
                itemBuilder: (BuildContext context, int i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 25),
                        decoration: BoxDecoration(
                          color: ConvertData.convertColor(shoes[i].color),
                          borderRadius: BorderRadius.all(
                            Radius.circular(24),
                          ),
                        ),
                        height: 350,
                        alignment: Alignment.center,
                        child: Transform.translate(
                          offset: Offset(-15,0),
                          child: Transform.rotate(
                            angle: -math.pi/4*25/45,
                            child: Image.network(shoes[i].image,height: 350,width: 350,),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: TextForm.textSel(
                          shoes[i].name,
                          style: TextStyle(
                            fontFamily: 'VariableFont_wght',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: AppColors.black,
                          ),
                        ),
                      ),
                      TextForm.textSel(
                        shoes[i].description,
                        style: TextStyle(
                          fontFamily: 'VariableFont_wght',
                          fontWeight: FontWeight.w100,
                          fontSize: 14,
                          color: AppColors.gray,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextForm.textSel(
                              '$s'+shoes[i].price.toString(),
                              style: TextStyle(
                                fontFamily: 'VariableFont_wght',
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: AppColors.black,
                              ),
                            ),
                            shoes[i].isChoice?
                            Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: AppColors.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                'assets/images/check.png',
                                width: 20,
                                height: 20,
                                fit: BoxFit.cover,
                              ),
                            ):
                            ElevatedButton(
                              onPressed: (!shoes[i].isChoice)?() {
                                Data.productBloc.add(AddCartEvent(vt: i));
                              }:null,
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.yellow,
                                padding: EdgeInsets.all(20),
                                shape: StadiumBorder(),
                              ),
                              child: Container(
                                height: 20,
                                child: Text(
                                  'ADD TO CART',
                                  style: TextStyle(
                                    fontFamily: 'VariableFont_wght',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: AppColors.black,
                                  ),
                                ),
                              ),
                            ),

                          ],
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