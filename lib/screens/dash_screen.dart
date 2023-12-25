import 'package:flutter/material.dart';
import 'package:sparky_game/games/game_sparky.dart';
import 'package:sparky_game/screens/main_screen.dart';
import 'package:confetti/confetti.dart';

class DashScreen extends StatefulWidget {
  static const String ID = 'DashScreen';
  final GameSparky gameRef;

  const DashScreen({super.key, required this.gameRef});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenter.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality
                .explosive, // don't specify a direction, blast randomly
            shouldLoop:
                true, // start again as soon as the animation is finished
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ], // manually specify the colors to be used
          ),
        ),
        Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.5,
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
                        text: "Thank you !",
                        textStyle: TextStyle(
                            fontSize: 45,
                            color: Color(0xffEE920C),
                            decoration: TextDecoration.none),
                        strokeColor: Color(0Xff333333),
                        strokeWidth: 3,
                      )),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  SizedBox(
                      // width: MediaQuery.of(context).size.width * 0.35,
                      height: MediaQuery.of(context).size.height * 0.2,
                      child: const Image(image: AssetImage('images/dash.png'))),
                  GestureDetector(
                      onTap: () {
                        widget.gameRef.removeMenu(menu: DashScreen.ID);
                        widget.gameRef.reset();
                        widget.gameRef.resumeEngine();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const MainScreen()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.09,
                        decoration: BoxDecoration(
                          color: const Color(0xffFFE98E), // Background color
                          borderRadius:
                              BorderRadius.circular(20.0), // Border radius
                        ),
                        child: const Center(
                          child: Text(
                            "Go back to Home",
                            style: TextStyle(
                                fontFamily: 'Poly',
                                fontSize: 20,
                                color: Color(0xff363636),
                                decoration: TextDecoration.none),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
