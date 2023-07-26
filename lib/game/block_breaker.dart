import 'package:flame/game.dart';

import '../../constants/constants.dart';
import 'component/ball.dart';
import 'component/paddle.dart';

class BlockBreaker extends FlameGame {
  @override
  Future<void>? onLoad() async {
    final paddle = Paddle();
    final paddleSize = paddle.size;
    paddle
      ..position.x = size.x / 2 - paddleSize.x / 2
      ..position.y = size.y - paddleSize.y - kPaddleStartY;

    await addAll([
      paddle,
    ]);
    
    resetBall();
  }

  Future<void> resetBall() async {
    final ball = Ball();

    ball.position
      ..x = size.x / 2 - ball.size.x / 2
      ..y = size.y * kBallStartYRatio;

    await add(ball);
  }
}