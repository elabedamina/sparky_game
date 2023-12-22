import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:sparky_game/components/sparky.dart';
import 'package:sparky_game/constants.dart';
import 'package:sparky_game/games/game_sparky.dart';

class NooglerHatComponent extends SpriteComponent
    with HasGameRef<GameSparky>, CollisionCallbacks {
  final double _spriteHeight = 50;
  final Random _random = Random();

  // Define the rectangular region (in percentage of screen size)
  final double _leftBoundaryPercentage = 0.2;
  final double _rightBoundaryPercentage = 0.8;
  final double _topBoundaryPercentage = 0.2;
  final double _bottomBoundaryPercentage = 0.8;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Constants.nooglerHatSprite);
    position = _createRandomPosition();
    height = width = _spriteHeight;
    anchor = Anchor.topCenter;
    add(CircleHitbox()..radius = 1);
  }

  Vector2 _createRandomPosition() {
    final double x = _random.nextDouble() *
            (gameRef.size.x *
                (_rightBoundaryPercentage - _leftBoundaryPercentage)) +
        (gameRef.size.x * _leftBoundaryPercentage);

    final double y = _random.nextDouble() *
            (gameRef.size.y *
                (_bottomBoundaryPercentage - _topBoundaryPercentage)) +
        (gameRef.size.y * _topBoundaryPercentage);

    return Vector2(x, y);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is SparkyComponent) {
      FlameAudio.play(Constants.grabSound);
      // Remove the collided item
      removeFromParent();
      gameRef.score += 1;
      gameRef.add(NooglerHatComponent());
    }
  }
}
