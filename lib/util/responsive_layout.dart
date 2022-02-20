import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget iphone;
  final Widget ipad;
  final Widget ipadTurned;
  final Widget macbook;

  const ResponsiveLayout({
    required this.ipad,
    required this.iphone,
    required this.ipadTurned,
    required this.macbook,
  }) ;

  static int iphoneLimit = 500;
  static int ipadLimit = 980;
  static int ipadMiniLimit = 750;
  static int ipadTurnedLimit = 1200;

  static bool isIphone(BuildContext context) =>
      MediaQuery.of(context).size.width < iphoneLimit;
  static bool isIpadWeb(BuildContext context) =>
      MediaQuery.of(context).size.width < ipadMiniLimit;
  static bool isIpad(BuildContext context) =>
      MediaQuery.of(context).size.width < ipadLimit &&
          MediaQuery.of(context).size.width >= iphoneLimit;

  static bool isIpadTurner(BuildContext context) =>
      MediaQuery.of(context).size.width < ipadTurnedLimit &&
          MediaQuery.of(context).size.width >= ipadLimit;
  static bool isIpadMini(BuildContext context) =>
      MediaQuery.of(context).size.width < ipadLimit &&
          MediaQuery.of(context).size.width >= ipadMiniLimit;

  static bool webMode(BuildContext context) =>
      MediaQuery.of(context).size.width >= ipadLimit;

  static double perWebMode(BuildContext context) {
    if(MediaQuery.of(context).size.width >= ipadLimit){
      return MediaQuery.of(context).size.width/ipadLimit+1;
    }else{
      return 1;
    }

  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          print("MAX WIDTH: ${constraints.maxWidth}");
          print("MAX HEIGHT: ${constraints.maxHeight}");
          if (constraints.maxWidth < iphoneLimit) return iphone;

          if (constraints.maxWidth < ipadLimit) return ipad;

          if (constraints.maxWidth < ipadTurnedLimit)
            return ipadTurned;
          else {
            return macbook;
          }
        });
  }
}