import 'dart:math';
import 'package:flutter/material.dart';
import 'package:simon_game/constants.dart';
import 'package:simon_game/simon_tile.dart';
import 'package:just_audio/just_audio.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final player = AudioPlayer();
  List<String> sounds = ['red', 'blue', 'green', 'yellow'];
  List<String> userClicks = [];
  List<String> gameFlow = [];
  int level = 1;
  Color btnColor = Colors.grey;

  //need to fix shadow effect
  bool isredClicked = false;
  bool isblueClicked = false;
  bool isgreenClicked = false;
  bool isyellowClicked = false;
  bool isbuttonClicked = false;
  bool isGameOver = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  bool compare(list1, list2) {
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  // When user clicks start button this function will be called and it generates a random sound.
  Future<Function> randomSound() async {
    int index = Random().nextInt(sounds.length);
    await player.setAsset('assets/${sounds[index]}.mp3');
    player.play();
    if (sounds[index] == 'red') {
      setState(() {
        isredClicked = !isredClicked;
      });
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        isredClicked = !isredClicked;
      });
    } else if (sounds[index] == 'blue') {
      setState(() {
        isblueClicked = !isblueClicked;
      });
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        isblueClicked = !isblueClicked;
      });
    } else if (sounds[index] == 'green') {
      setState(() {
        isgreenClicked = !isgreenClicked;
      });
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        isgreenClicked = !isgreenClicked;
      });
    } else if (sounds[index] == 'yellow') {
      setState(() {
        isyellowClicked = !isyellowClicked;
      });
      await Future.delayed(Duration(milliseconds: 100));
      setState(() {
        isyellowClicked = !isyellowClicked;
      });
    }

    gameFlow.add(sounds[index]);
    return null;
  }

  void gameOver() async {
    setState(() {
      isGameOver = !isGameOver;
      level = 0;
      userClicks = [];
      gameFlow = [];
    });
    await player.setAsset('assets/wrong.mp3');
    player.play();
    // clearing everything
    Future.delayed(Duration(seconds: 1));
    setState(() {
      isGameOver = !isGameOver;
    });
  }

  // This function checks user clicks
  Future<Function> checkUserClicks() async {
    // Checking whether both lengths are equal or not
    // If both lengths are equal then we need to increase the game level
    if (gameFlow.length == userClicks.length) {
      // Checking if user clicks are equal to game flow
      if (compare(userClicks, gameFlow)) {
        // leveling up and clearing the userClicks because
        // user needs to type the entire game flow from starting onwards. That's what the game is for right!!
        setState(() {
          level++;
          userClicks = [];
        });
        // For every new level a new sound will generate and added to game flow
        randomSound();
      }
      // If user clicks are not equal to game flow then it means game over
      else {
        gameOver();
      }
    }
    // If user clicks are less than game flow then it means the user is not yet done clicking.
    // So we need to check each and every time when user clicks whether he/she is on the right track or not.
    else {
      if (!compare(userClicks, gameFlow)) {
        gameOver();
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "SIMON GAME",
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.grey,
        elevation: 0.0,
      ),
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Score board container
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 9,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 10.0,
                  ),
                ),
                margin: EdgeInsets.only(bottom: 20.0),
                child: Center(
                  child: Text(
                    "LEVEL: $level",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height / 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3.0,
                    ),
                  ),
                ),
              ),
              // Four coloured tiles
              Container(
                decoration: BoxDecoration(
                    boxShadow: isGameOver ? [boxShadowForGameOver] : []),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SimonTile(
                          color: Colors.red,
                          clickedShadow: isredClicked ? boxShadow : BoxShadow(),
                          onTap: () async {
                            setState(() {
                              isredClicked = !isredClicked;
                            });
                            await Future.delayed(Duration(milliseconds: 100));
                            setState(() {
                              isredClicked = !isredClicked;
                            });
                            await player.setAsset('assets/red.mp3');
                            player.play();
                            await Future.delayed(Duration(milliseconds: 500));
                            userClicks.add('red');
                            checkUserClicks();
                          },
                        ),
                        SimonTile(
                          color: Colors.blue,
                          clickedShadow:
                              isblueClicked ? boxShadow : BoxShadow(),
                          onTap: () async {
                            setState(() {
                              isblueClicked = !isblueClicked;
                            });
                            await Future.delayed(Duration(milliseconds: 100));
                            setState(() {
                              isblueClicked = !isblueClicked;
                            });
                            await player.setAsset('assets/blue.mp3');
                            player.play();
                            await Future.delayed(Duration(milliseconds: 500));
                            userClicks.add('blue');
                            checkUserClicks();
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SimonTile(
                          color: Colors.green,
                          clickedShadow:
                              isgreenClicked ? boxShadow : BoxShadow(),
                          onTap: () async {
                            setState(() {
                              isgreenClicked = !isgreenClicked;
                            });
                            await Future.delayed(Duration(milliseconds: 100));
                            setState(() {
                              isgreenClicked = !isgreenClicked;
                            });
                            await player.setAsset('assets/green.mp3');
                            player.play();
                            await Future.delayed(Duration(milliseconds: 500));
                            userClicks.add('green');

                            checkUserClicks();
                          },
                        ),
                        SimonTile(
                          color: Colors.yellow,
                          clickedShadow:
                              isyellowClicked ? boxShadow : BoxShadow(),
                          onTap: () async {
                            setState(() {
                              isyellowClicked = !isyellowClicked;
                            });
                            await Future.delayed(Duration(milliseconds: 100));
                            setState(() {
                              isyellowClicked = !isyellowClicked;
                            });
                            await player.setAsset('assets/yellow.mp3');
                            player.play();
                            await Future.delayed(Duration(milliseconds: 500));
                            userClicks.add('yellow');
                            checkUserClicks();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  // color: Colors.purple,
                  color: btnColor,
                  border: Border.all(
                    color: Colors.black,
                    width: 5.0,
                  ),
                ),
                margin: EdgeInsets.all(20.0),
                child: TextButton(
                  onPressed: () async {
                    setState(() {
                      btnColor = Colors.black;
                    });
                    await Future.delayed(Duration(milliseconds: 100));
                    setState(() {
                      btnColor = Colors.grey;
                    });
                    userClicks = [];
                    gameFlow = [];
                    level = 1;
                    randomSound();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    height: MediaQuery.of(context).size.height / 16,
                    child: Center(
                      child: Text(
                        "START",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 4.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "Developed by ❤️ END Prasad",
              )
            ],
          ),
        ),
      ),
    );
  }
}
