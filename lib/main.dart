import 'package:flutter/material.dart';
import 'package:simon_game/game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simon Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}
