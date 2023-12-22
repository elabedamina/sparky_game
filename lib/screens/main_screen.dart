import 'package:flutter/material.dart';
import 'package:sparky_game/screens/game_play.dart';

class MainScreen extends StatelessWidget {
  static const String ID = 'MainScreen';

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background_main.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Container(
                  alignment: Alignment.center,
                  child: const StrokeText(
                    text: "SPARKY\nGAME",
                    textStyle:
                        TextStyle(fontSize: 60, color: Color(0xffEE920C)),
                    strokeColor: Color(0Xff333333),
                    strokeWidth: 5,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const GamePlay()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.1,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFE98E), // Background color
                      borderRadius:
                          BorderRadius.circular(40.0), // Border radius
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.play_arrow,
                            size: MediaQuery.of(context).size.width *
                                0.1, // Adjust the size as needed
                            color: const Color(0xffB97408)), // A

                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01),
                        const StrokeText(
                          text: "PLAY",
                          textStyle:
                              TextStyle(fontSize: 30, color: Color(0xffEE920C)),
                          strokeColor: Color(0XffB97408),
                          strokeWidth: 3,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        )
      ]),
    );
  }
}

class StrokeText extends StatelessWidget {
  final String text;
  final double strokeWidth;
  final Color textColor;
  final Color strokeColor;
  final TextStyle? textStyle;

  const StrokeText(
      {Key? key,
      required this.text,
      this.strokeWidth = 1,
      this.strokeColor = Colors.black,
      this.textColor = Colors.white,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Coiny',
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth
              ..color = strokeColor,
          ).merge(textStyle),
          textAlign: TextAlign.center,
        ),
        Text(
          text,
          textAlign: TextAlign.center,
          style:
              TextStyle(color: textColor, fontFamily: 'Coiny').merge(textStyle),
        ),
      ],
    );
  }
}
