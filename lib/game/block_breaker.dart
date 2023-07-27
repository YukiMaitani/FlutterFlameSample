import 'package:flame/events.dart';
import 'package:flame/game.dart';

import '../../constants/constants.dart';
import 'component/ball.dart';
import 'component/block.dart';
import 'component/paddle.dart';

class BlockBreaker extends FlameGame with HasDraggablesBridge{
  @override
  Future<void>? onLoad() async {
    final paddle = Paddle(draggingPaddle: draggingPaddle);
    final paddleSize = paddle.size;
    paddle
      ..position.x = size.x / 2 - paddleSize.x / 2
      ..position.y = size.y - paddleSize.y - kPaddleStartY;

    await addAll([
      paddle,
    ]);

    resetBall();
    resetBlock();
  }

  Future<void> resetBall() async {
    final ball = Ball();

    ball.position
      ..x = size.x / 2 - ball.size.x / 2
      ..y = size.y * kBallStartYRatio;

    await add(ball);
  }

  Future<void> resetBlock() async {
    final sizeX = (size.x -
            kBlocksStartXPosition * 2 -
            kBlockPadding * (kBlocksRowCount - 1)) /
        kBlocksRowCount;

    final sizeY = (size.y * kBlocksHeightRatio -
            kBlocksStartYPosition -
            kBlockPadding * (kBlocksColumnCount - 1)) /
        kBlocksColumnCount;
    final blocks =
        List<Block>.generate(kBlocksColumnCount * kBlocksRowCount, (int index) {
      final block = Block(
        blockSize: Vector2(sizeX, sizeY),
      );
      final indexX = index % kBlocksRowCount;
      final indexY = index ~/ kBlocksRowCount;

      block.position
        ..x = kBlocksStartXPosition + indexX * (block.size.x + kBlockPadding)
        ..y = kBlocksStartYPosition + indexY * (block.size.y + kBlockPadding);

      return block;
    });

    await addAll(blocks);
  }

  void draggingPaddle(DragUpdateEvent event) {
    final paddle = children.whereType<Paddle>().first;
    paddle.position.x += event.delta.x;
    if (paddle.position.x < 0) {
      paddle.position.x = 0;
    } else if (paddle.position.x + paddle.size.x > size.x) {
      paddle.position.x = size.x - paddle.size.x;
    }
  }
}
