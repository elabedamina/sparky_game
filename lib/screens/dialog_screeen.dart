import 'package:flutter/material.dart';
import 'package:sparky_game/screens/game_play.dart';

class DialogScreen extends StatelessWidget {
  static const String ID = 'DialogScreen';

  const DialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(children: [
        // Background Image
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background_dialog.png'),
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
                    text: "WELCOME !",
                    textStyle: TextStyle(
                        fontSize: 60,
                        color: Color(0xffEE920C),
                        decoration: TextDecoration.none),
                    strokeColor: Color(0Xff333333),
                    strokeWidth: 5,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.09,
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: const Color(0xffD7FFFF)
                        .withOpacity(0.4), // Background color
                    borderRadius: BorderRadius.circular(40.0), // Border radius
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.height * 0.025,
                          right: MediaQuery.of(context).size.height * 0.025),
                      child: const Text(
                        "I recently had purchased some thoughtful gifts for my close friend Dash's upcoming birthday. Unfortunately, the Android bugs got jealous and took away the presents. Help me get them back and ensure that Dash has a memorable birthday.",
                        style: TextStyle(
                            fontFamily: 'Poly',
                            fontSize: 20,
                            color: Color(0xff363636),
                            decoration: TextDecoration.none),
                      ),
                    ),
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('images/sparky_dialog.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const GamePlay()));
                      },
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.07,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFE98E), // Background color
                            borderRadius:
                                BorderRadius.circular(20.0), // Border radius
                          ),
                          child: const Center(
                            child: Text(
                              "Start",
                              style: TextStyle(
                                  fontFamily: 'Poly',
                                  fontSize: 25,
                                  color: Color(0xff363636),
                                  decoration: TextDecoration.none),
                            ),
                          ))),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                ],
              ),
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
