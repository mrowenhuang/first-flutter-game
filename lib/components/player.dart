import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:my_first_game/pixel_advanture.dart';

enum PlayerState { idle, running }

enum PlayerDirection { left, right, none }

class Player extends SpriteAnimationGroupComponent
    with HasGameReference<PixelAdvanture>, KeyboardHandler {
  String characters;
  Player({this.characters = 'Ninja Frog', position})
    : super(position: position);

  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  final double stepTime = 0.05;

  PlayerDirection playerDirection = PlayerDirection.none;

  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;

  @override
  FutureOr<void> onLoad() {
    // TODO: implement onLoad

    _loadAllAnimation();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    _updatePlayerMovement(dt);
    super.update(dt);
  }

  // @override
  // bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
  //   // TODO: implement onKeyEvent
  //   final isLeftKeyPressed =
  //       keysPressed.contains(LogicalKeyboardKey.keyA) ||
  //       keysPressed.contains(LogicalKeyboardKey.arrowLeft);
  //   final isRightKeyPressed =
  //       keysPressed.contains(LogicalKeyboardKey.keyD) ||
  //       keysPressed.contains(LogicalKeyboardKey.arrowRight);
  //   final isStopKeyPressed =
  //       keysPressed.contains(LogicalKeyboardKey.keyS) ||
  //       keysPressed.contains(LogicalKeyboardKey.arrowDown);

  //   if (isLeftKeyPressed && isRightKeyPressed) {
  //     playerDirection = PlayerDirection.none;
  //   } else if (isRightKeyPressed) {
  //     playerDirection = PlayerDirection.right;
  //   } else if (isLeftKeyPressed) {
  //     playerDirection = PlayerDirection.left;
  //   } else if (isStopKeyPressed) {
  //     playerDirection = PlayerDirection.none;
  //   }

  //   print(playerDirection);

  //   return super.onKeyEvent(event, keysPressed);
  // }

  void _loadAllAnimation() {
    idleAnimation = _spriteAnimation('Idle', 11);

    runningAnimation = _spriteAnimation('Run', 12);

    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runningAnimation,
    };

    current = PlayerState.running;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Main Characters/$characters/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _updatePlayerMovement(double dt) {
    double dirX = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        current = PlayerState.running;
        dirX -= moveSpeed;
        break;
      case PlayerDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        current = PlayerState.running;
        dirX += moveSpeed;
        break;
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;
    }
    velocity = Vector2(dirX, 0.0);
    position += velocity * dt;
  }
}
