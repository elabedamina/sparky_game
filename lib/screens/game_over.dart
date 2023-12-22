import 'package:flutter/material.dart';
import 'package:sparky_game/games/game_sparky.dart';
import 'package:sparky_game/screens/main_screen.dart';

class GameOver extends StatelessWidget {
  static const String ID = 'GameOver';
  final GameSparky gameRef;

  const GameOver({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
            color: const Color(0xffFFE98E).withOpacity(0.8),
            borderRadius: BorderRadius.circular(40.0)),
        child: Column(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.05),
                      child: const StrokeText(
                        text: "GAME\nOVER",
                        textStyle:
                            TextStyle(fontSize: 40, color: Color(0xffEE920C)),
                        strokeColor: Color(0Xff333333),
                        strokeWidth: 5,
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.03),
                    child: Text(
                      'Score: ${gameRef.score}',
                      style: const TextStyle(
                          fontSize: 35,
                          fontFamily: 'Coiny',
                          color: Colors.black),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  GestureDetector(
                      onTap: () {
                        gameRef.removeMenu(menu: GameOver.ID);
                        gameRef.reset();
                        gameRef.resumeEngine();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 139, 201, 240)
                              .withOpacity(0.9), // Background color
                          borderRadius:
                              BorderRadius.circular(40.0), // Border radius
                        ),
                        child: const Center(
                          child: StrokeText(
                            text: "play again?",
                            textStyle: TextStyle(
                                fontSize: 25,
                                color: Color.fromARGB(255, 33, 106, 151)),
                            strokeColor: Color.fromARGB(255, 21, 64, 91),
                            strokeWidth: 1,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
