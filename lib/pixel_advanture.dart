import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:my_first_game/components/player.dart';
import 'package:my_first_game/components/level.dart';

class PixelAdvanture extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  @override
  Color backgroundColor() => Color(0xffffffff);

  late final CameraComponent cam;
  Player player = Player();
  late JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() async {
    // TODO: implement onLoad

    final world = Level(levelName: 'level-01', player: player);

    await images.loadAllImages();

    addJoyStick();

    cam = CameraComponent.withFixedResolution(
      width: 640,
      height: 360,
      world: world,
    );
    cam.viewfinder.anchor = Anchor.topLeft;

    addAll([cam, world]);

    return super.onLoad();
  }

  @override
  void update(double dt) {
    // TODO: implement update
    updateJotStick();
    super.update(dt);
  }

  void addJoyStick() {
    joystick = JoystickComponent(
      knob: SpriteComponent(sprite: Sprite(images.fromCache('HUD/knob.png'))),
      background: SpriteComponent(
        sprite: Sprite(images.fromCache('HUD/joystick.png')),
      ),
      margin: EdgeInsets.only(bottom: 32, left: 32),
    );

    add(joystick);
  }

  void updateJotStick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.playerDirection = PlayerDirection.right;
        break;
      default:
        player.playerDirection = PlayerDirection.none;
        break;
    }
  }
}
