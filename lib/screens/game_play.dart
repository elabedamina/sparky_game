import "package:flame/game.dart";
import "package:flutter/material.dart";
import "package:sparky_game/games/game_sparky.dart";
import "package:sparky_game/screens/dash_screen.dart";
import "package:sparky_game/screens/game_over.dart";

final GameSparky _sparkyGame = GameSparky();

class GamePlay extends StatelessWidget {
  const GamePlay({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: _sparkyGame, overlayBuilderMap: {
      GameOver.ID: (BuildContext context, GameSparky gameRef) =>
          GameOver(gameRef: gameRef),
      DashScreen.ID: (BuildContext context, GameSparky gameRef) =>
          DashScreen(gameRef: gameRef)
    });
  }
}
