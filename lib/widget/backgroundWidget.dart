import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoe_live/util/colors.dart';
import 'package:shoe_live/util/wave.dart';

class BackGroundWidget extends StatelessWidget{
  Widget wid;
  BackGroundWidget({Key? key,required this.wid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(24),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: AppColors.gray.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      height: 600,
      width: 350,
      child: Stack(
        children: [
          ClipPath(
            clipper: WaveParClipper(),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(24),
                ),
                color: AppColors.yellow,
              ),
            ),
          ),
          wid,
        ],
      ),
    );
  }

}