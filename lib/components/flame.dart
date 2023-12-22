import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sparky_game/components/sparky.dart';
import 'package:sparky_game/constants.dart';
import 'package:sparky_game/games/game_sparky.dart';
import 'dart:math' as math;

class FlameComponent extends SpriteComponent
    with HasGameRef<GameSparky>, CollisionCallbacks {
  final double _spriteHeight = 50.0;

  late Vector2 _velocity;

  double speed = 20;

  final double degree = math.pi / 180;

  FlameComponent();

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite(Constants.flameSprite);

    position = Vector2(200, 200);

    final double spawnAngle = _getSpawnAngle();

    final double vx = math.cos(spawnAngle * degree) * speed;
    final double vy = math.sin(spawnAngle * degree) * speed;

    _velocity = Vector2(vx, vy);

    // Set dimensions of santa sprite.
    width = _spriteHeight;
    height = _spriteHeight;

    // Set anchor of component.
    anchor = Anchor.center;

    add(CircleHitbox()..radius = 1);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _velocity * dt;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is ScreenHitbox) {
      final Vector2 collisionPoint = intersectionPoints.first;
      const double margin = 0.01;

      if (collisionPoint.x == 0) {
        _velocity.x = -_velocity.x;
      }
      if ((collisionPoint.x - (gameRef.size.x - margin)).abs() < margin) {
        _velocity.x = -_velocity.x;
      }
      if (collisionPoint.y == 0) {
        _velocity.y = -_velocity.y;
      }
      if ((collisionPoint.y - (gameRef.size.y - margin)).abs() < margin) {
        _velocity.y = -_velocity.y;
      }
    }

    if (other is SparkyComponent) {
      removeFromParent();
    }
  }

  double _getSpawnAngle() {
    final random = math.Random().nextDouble();
    final spawnAngle = lerpDouble(0, 360, random)!;

    return spawnAngle;
  }
}
