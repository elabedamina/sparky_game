import 'package:flame/components.dart';
import 'package:sparky_game/constants.dart';
import 'package:sparky_game/games/game_sparky.dart';

class BackgroundComponent extends SpriteComponent with HasGameRef<GameSparky> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Constants.backgroundSprite);
    size = gameRef.size;
  }
}
