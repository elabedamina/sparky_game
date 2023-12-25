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
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.45,
        decoration: BoxDecoration(
            color: const Color(0xffD7FFFF).withOpacity(0.55),
            borderRadius: BorderRadius.circular(40.0)),
        child: Center(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: const StrokeText(
                    text: "Game\nover !",
                    textStyle: TextStyle(
                        fontSize: 50,
                        color: Color(0xffEE920C),
                        decoration: TextDecoration.none),
                    strokeColor: Color(0Xff333333),
                    strokeWidth: 4,
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.03),
                child: Text(
                  'Score: ${gameRef.score}',
                  style: const TextStyle(
                      fontFamily: 'Poly',
                      fontSize: 35,
                      color: Color(0xff363636),
                      decoration: TextDecoration.none),
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
                    width: MediaQuery.of(context).size.width * 0.48,
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFE98E), // Background color
                      borderRadius:
                          BorderRadius.circular(20.0), // Border radius
                    ),
                    child: const Center(
                      child: Text(
                        "play again?",
                        style: TextStyle(
                            fontFamily: 'Poly',
                            fontSize: 25,
                            color: Color(0xff363636),
                            decoration: TextDecoration.none),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
