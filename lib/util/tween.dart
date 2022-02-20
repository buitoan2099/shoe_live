import 'dart:math';
import 'package:flutter/animation.dart';

class TweenDelay extends Tween<double> {
  final double delay;

  TweenDelay({required double begin, required double end, required this.delay})
      : super(begin: begin, end: end);

  @override
  double lerp(double t) {
    // link đến công thức
    // https://github.com/jogboms/flutter_spinkit/blob/master/lib/src/tweens/delay_tween.dart
    return super.lerp((sin((t - delay) * 2 * pi) + 1) / 2);
  }

  @override
  double evaluate(Animation<double> animation) => lerp(animation.value);
}
