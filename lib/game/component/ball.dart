import 'dart:ui';

import 'package:flame/components.dart';

import '../../constants/constants.dart';

class Ball extends CircleComponent {
  Ball() {
    radius = kBallRadius;
    paint = Paint()..color = kBallColor;
  }
}