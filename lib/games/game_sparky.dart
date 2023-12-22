import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:sparky_game/components/android_bug.dart';
import 'package:sparky_game/components/flame.dart';
import 'package:sparky_game/constants.dart';
import 'package:sparky_game/components/background.dart';
import 'package:sparky_game/components/joystick.dart';
import 'package:sparky_game/components/noogler_hat.dart';
import 'package:sparky_game/components/sparky.dart';
import 'package:sparky_game/screens/dash_screen.dart';
import 'package:sparky_game/screens/game_over.dart';

class GameSparky extends FlameGame with DragCallbacks, HasCollisionDetection {
  int score = 0;
  late Timer _timer;
  int _remainingTime = 35;
  late TextComponent _scoreText;
  late TextComponent _timerText;

  static int flameAppearance = _getRandomInt(
    min: 10,
    max: 35,
  );

  static int _getRandomInt({
    required int min,
    required int max,
  }) {
    Random rng = Random();
    return rng.nextInt(max - min) + min;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    add(BackgroundComponent());

    add(SparkyComponent(joystick: joystick));
    add(NooglerHatComponent());
    add(joystick);
    add(AndroidBugComponent(startPosition: Vector2(100, 50)));

    FlameAudio.audioCache.loadAll(
        [Constants.grabSound, Constants.hitSound, Constants.flameSound]);

    add(ScreenHitbox());

    _timer = Timer(1, repeat: true, onTick: () {
      if (_remainingTime == 0) {
        pauseEngine();
        overlays.add(GameOver.ID);
      } else {
        if (_remainingTime == flameAppearance) {
          add(FlameComponent());
        }

        _remainingTime -= 1;
      }
    });

    _timer.start();

    _scoreText = TextComponent(
      text: 'Score: $score',
      position: Vector2(40, 50),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color(0xFFE89512),
          fontSize: 20,
        ),
      ),
    );

    add(_scoreText);

    _timerText = TextComponent(
      text: 'Time: $_remainingTime',
      position: Vector2(size.x - 40, 50),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: const TextStyle(
          color: Color(0xFFE89512),
          fontSize: 20,
          fontFamily: 'Coiny',
        ),
      ),
    );

    // Add Score TextComponent.
    add(_timerText);
  }

  @override
  void update(double dt) {
    super.update(dt);

    _timer.update(dt);

    _scoreText.text = 'Score: $score';
    _timerText.text = 'Time: $_remainingTime secs';
    if (score == 15) {
      pauseEngine();
      reset();
      overlays.add(DashScreen.ID);
    }
  }

  void reset() {
    score = 0;
    _remainingTime = 35;

    flameAppearance = _getRandomInt(
      min: 10,
      max: 35,
    );
  }

  void addMenu({
    required String menu,
  }) {
    overlays.add(menu);
  }

  void removeMenu({
    required String menu,
  }) {
    overlays.remove(menu);
  }
}
