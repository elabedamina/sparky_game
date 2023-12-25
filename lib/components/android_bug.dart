import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:sparky_game/constants.dart';
import 'package:sparky_game/games/game_sparky.dart';
import 'dart:math' as math;

class AndroidBugComponent extends SpriteComponent
    with HasGameRef<GameSparky>, CollisionCallbacks {
  final double _spriteHeight = 90;
  final Vector2 startPosition;
  late Vector2 _velocity;
  double speed = 150;
  double degree = math.pi / 180;

  AndroidBugComponent({required this.startPosition});
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Constants.androidBugSprite);
    position = startPosition;
    height = _spriteHeight;
    width = _spriteHeight + 1.42;
    anchor = Anchor.center;
    double spawnAngle = _getSpawnAngle();

    final double vx = math.cos(spawnAngle * degree) * speed;
    final double vy = math.sin(spawnAngle * degree) * speed;

    _velocity = Vector2(vx, vy);

    add(CircleHitbox()..radius = 1);
  }

  @override
  void update(double dt) {
    super.update(dt);

    position += _velocity * dt;
  }

  double _getSpawnAngle() {
    final random = math.Random().nextDouble();
    final spawnAngle = lerpDouble(0, 360, random)!;

    return spawnAngle;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is ScreenHitbox) {
      final Vector2 collisionPoint = intersectionPoints.first;
      const double margin = 0.01;
      // If the bug has collided from above or below, it should bounce upwards
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
  }
}
