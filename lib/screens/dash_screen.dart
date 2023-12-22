import 'package:flutter/material.dart';
import 'package:sparky_game/games/game_sparky.dart';
import 'package:sparky_game/screens/main_screen.dart';

class DashScreen extends StatelessWidget {
  // ignore: constant_identifier_names
  static const String ID = 'DashScreen';
  final GameSparky gameRef;

  const DashScreen({super.key, required this.gameRef});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.65,
        height: MediaQuery.of(context).size.height * 0.55,
        decoration: BoxDecoration(
            color: const Color(0xffFFE98E).withOpacity(0.8),
            borderRadius: BorderRadius.circular(40.0)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const StrokeText(
                text: "The gifts were\nall collected\nsuccessfuly!",
                textStyle: TextStyle(fontSize: 30, color: Color(0xffEE920C)),
                strokeColor: Color(0Xff333333),
                strokeWidth: 1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: const Image(image: AssetImage('images/dash.png'))),
            ],
          ),
        ),
      ),
    );
  }
}
