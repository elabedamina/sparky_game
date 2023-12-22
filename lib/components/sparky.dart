import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:sparky_game/components/android_bug.dart';
import 'package:sparky_game/components/flame.dart';
import 'package:sparky_game/constants.dart';
import 'package:sparky_game/games/game_sparky.dart';

enum MouvmentState { center, slideLeft, slideRight, hit }

class SparkyComponent extends SpriteGroupComponent<MouvmentState>
    with HasGameRef<GameSparky>, CollisionCallbacks {
  final double _spriteHeight = 90;
  static const double _originalSpeed = 250.0;
  static double _speed = _originalSpeed;

  late double _rightBoundary;
  late double _leftBoundary;
  late double _upBoundary;
  late double _downBoundary;

  JoystickComponent joystick;

  bool isHit = false;
  final Timer _timer = Timer(1);
  final Timer _timerSpeed = Timer(6);

  SparkyComponent({required this.joystick});

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    Sprite sparkyCenter =
        await gameRef.loadSprite(Constants.sparkyCenterSprite);
    Sprite sparkySlideLeft =
        await gameRef.loadSprite(Constants.sparkySlideLeftSprite);
    Sprite sparkySlideRight =
        await gameRef.loadSprite(Constants.sparkySlideRightSprite);
    Sprite sparkyHit = await gameRef.loadSprite(Constants.sparkyHitSprite);

    sprites = {
      MouvmentState.center: sparkyCenter,
      MouvmentState.slideLeft: sparkySlideLeft,
      MouvmentState.slideRight: sparkySlideRight,
      MouvmentState.hit: sparkyHit
    };

    _rightBoundary = gameRef.size.x - 55;
    _leftBoundary = 55;
    _upBoundary = 55;
    _downBoundary = gameRef.size.y - 55;

    current = MouvmentState.center;

    position = gameRef.size / 2;
    height = _spriteHeight;
    width = _spriteHeight + 1.42;
    anchor = Anchor.center;
    add(CircleHitbox()..radius = 1);
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!isHit) {
      if (joystick.direction == JoystickDirection.idle) {
        current = MouvmentState.center;
        return;
      }
      //if sparky is exiting the boundaries
      if (x >= _rightBoundary) {
        x = _rightBoundary - 1;
      }

      if (x <= _leftBoundary) {
        x = _leftBoundary + 1;
      }

      if (y >= _downBoundary) {
        y = _downBoundary - 1;
      }

      if (y <= _upBoundary) {
        y = _upBoundary + 1;
      }

      bool moveLeft = joystick.relativeDelta[0] < 0;

      if (moveLeft) {
        current = MouvmentState.slideLeft;
      } else {
        current = MouvmentState.slideRight;
      }
      _timerSpeed.update(dt);
      if (_timerSpeed.finished) {
        _resetSpeed();
      }
      position.add(joystick.relativeDelta * _speed * dt);
    } else {
      _timer.update(dt);
      if (_timer.finished) {
        _removeHitSparky();
      }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is AndroidBugComponent) {
      if (!isHit) {
        _hitSparky();
      }
    }

    if (other is FlameComponent) {
      _increaseSpeed();
    }
  }

  void _hitSparky() {
    if (!isHit) {
      isHit = true;
      FlameAudio.play(Constants.hitSound);
      current = MouvmentState.hit;
      _timer.start();
    }
  }

  void _removeHitSparky() {
    isHit = false;
    current = MouvmentState.center;
  }

  void _increaseSpeed() {
    FlameAudio.play(Constants.flameSound);
    _speed *= 2;
    _timerSpeed.start();
  }

  void _resetSpeed() {
    _speed = _originalSpeed;
  }
}
