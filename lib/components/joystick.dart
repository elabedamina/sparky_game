import 'package:flame/components.dart';
import 'package:flutter/material.dart';

final JoystickComponent joystick = JoystickComponent(
  knob: CircleComponent(
    radius: 15,
    paint: Paint()..color = const Color(0xFF53B4F2),
  ),
  background: CircleComponent(
    radius: 50,
    paint:  Paint()..color = const Color(0xFF80D9F4).withOpacity(0.6),
  ),
  margin: const EdgeInsets.only(left: 40, bottom: 40),
);
