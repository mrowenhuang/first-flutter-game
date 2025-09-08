import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_first_game/pixel_advanture.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();

  PixelAdvanture game = PixelAdvanture();
  runApp(GameWidget(game: kDebugMode ? PixelAdvanture() : game));
}
