import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoe_live/bloc/product.dart';
import 'package:shoe_live/util/colors.dart';
import 'package:shoe_live/util/responsive_layout.dart';
import 'package:shoe_live/util/tween.dart';
import 'package:shoe_live/util/wave.dart';
import 'package:shoe_live/model/cart.dart';
import 'package:shoe_live/model/data.dart';
import 'dart:math' as math;

import 'package:shoe_live/model/shoe.dart';
import 'package:shoe_live/widget/CartWidget.dart';
import 'package:shoe_live/widget/backgroundWidget.dart';
import 'package:shoe_live/widget/productWidget.dart';


class MainPage extends StatefulWidget {

  MainPage({Key? key,}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late ProductBloc productBloc;
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds:10), vsync: this)
      ..repeat();
    productBloc = ProductBloc(InitProductState(),context,);
    Data.productBloc = productBloc;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
          SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0),
              end: const Offset(0, -0.2),
            ).animate(TweenDelay(begin: 0, end: -0.5, delay: 0).animate(_controller),),
            child:Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationX(math.pi),
              child: ClipPath(
                clipper: WaveClipper(),
                child: Container(
                  height: size.height,
                  width: size.width,
                  color: AppColors.yellow,
                ),
              ),
            ),
          ),
          ListView(
            controller: controller,
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              BlocBuilder<ProductBloc,ProductState>(
                bloc: productBloc,
                builder: (context,state){
                  if (state is InitProductState){
                    productBloc.add(GetData());
                  }
                  if (!ResponsiveLayout.isIpadWeb(context)){
                    return Container(
                      alignment: Alignment.center,
                      height: (size.height>620)?size.height-50:620,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BackGroundWidget(
                            wid: ProductWidget(shoes: state.shoes,controller: controller,),
                          ),
                          SizedBox(width: 40,),
                          BackGroundWidget(
                            wid: CartWidget(carts: state.carts,cost: state.cost,controller: controller,),
                          ),
                        ],
                      ),
                    );
                  }
                  else{
                    return Container(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Column(
                        children: [
                          BackGroundWidget(
                            wid: ProductWidget(shoes: state.shoes,controller: controller,),
                          ),
                          SizedBox(height: 40,),
                          BackGroundWidget(
                            wid: CartWidget(carts: state.carts,cost: state.cost,controller: controller,),
                          ),
                        ],
                      ),
                    );
                  }


                },
              ),

            ],
          ),
        ],
      ),
    );
  }
}