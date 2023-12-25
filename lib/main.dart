import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sparky_game/screens/dialog_screeen.dart';
import 'package:sparky_game/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: SafeArea(child: MainScreen())));
}
