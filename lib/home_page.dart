/* Developed by: Eng. Mouaz M. Al-Shahmeh */
import 'dart:async';
import 'package:bomber_man_flutter_game/button.dart';
import 'package:bomber_man_flutter_game/pixel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int numberOfSquares = 120;
  int playerPosition = 0;
  int bombPosition = -1;
  bool win = false;
  bool loose = false;
  List<int> barriers = [
    11,
    13,
    15,
    17,
    18,
    31,
    33,
    35,
    37,
    38,
    51,
    53,
    55,
    57,
    58,
    71,
    73,
    75,
    77,
    78,
    91,
    93,
    95,
    97,
    98,
    111,
    113,
    115,
    117,
    118
  ];

  List<int> boxes = [
    12,
    14,
    16,
    28,
    21,
    41,
    61,
    81,
    101,
    112,
    114,
    116,
    119,
    103,
    83,
    63,
    65,
    67,
    47,
    39,
    19,
    1,
    50,
    70,
    100,
    96,
    79,
    99,
    107,
    7,
    3
  ];

  List<int> fire = [-1];

  void moveUp() {
    setState(() {
      if (playerPosition - 10 >= 0 &&
          !barriers.contains(playerPosition - 10) &&
          !boxes.contains(playerPosition - 10)) {
        playerPosition -= 10;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if (!(playerPosition % 10 == 0) &&
          !barriers.contains(playerPosition - 1) &&
          !boxes.contains(playerPosition - 1)) {
        playerPosition -= 1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if (!(playerPosition % 10 == 9) &&
          !barriers.contains(playerPosition + 1) &&
          !boxes.contains(playerPosition + 1)) {
        playerPosition += 1;
      }
    });
  }

  void moveDown() {
    setState(() {
      if (playerPosition + 10 < numberOfSquares &&
          !barriers.contains(playerPosition + 10) &&
          !boxes.contains(playerPosition + 10)) {
        playerPosition += 10;
      }
    });
  }

  void placeBomb() {
    setState(() {
      bombPosition = playerPosition;
      fire.clear();
      Timer(const Duration(milliseconds: 1500), () {
        setState(() {
          fire.add(bombPosition);
          fire.add(bombPosition - 1);
          fire.add(bombPosition + 1);
          fire.add(bombPosition - 10);
          fire.add(bombPosition + 10);
          fire.add(bombPosition - 2);
          fire.add(bombPosition + 2);
          fire.add(bombPosition - 20);
          fire.add(bombPosition + 20);
        });
        clearFire();
        bombPosition = -1;
      });
    });
  }

  void clearFire() {
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        for (int i = 0; i < fire.length; i++) {
          if (boxes.contains(fire[i])) {
            boxes.remove(fire[i]);
          }
          if (fire[i] == playerPosition) {
            loose = true;
          }
        }
        fire.clear();
        if (boxes.isEmpty) {
          win = true;
        }
      });
    });
  }

  void reset() {
    setState(() {
      win = false;
      loose = false;
      playerPosition = 0;
      bombPosition = -1;
      boxes = [
        12,
        14,
        16,
        28,
        21,
        41,
        61,
        81,
        101,
        112,
        114,
        116,
        119,
        103,
        83,
        63,
        65,
        67,
        47,
        39,
        19,
        1,
        50,
        70,
        100,
        96,
        79,
        99,
        107,
        7,
        3
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: win == false && loose == false
                ? GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      if (fire.contains(index)) {
                        return MyPixel(
                          innerColor: Colors.red,
                          outerColor: Colors.red[900],
                        );
                      } else if (bombPosition == index) {
                        return MyPixel(
                          innerColor: Colors.green,
                          outerColor: Colors.green[800],
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Image.asset(
                              'lib/images/pokeball.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else if (playerPosition == index) {
                        return MyPixel(
                          innerColor: Colors.green,
                          outerColor: Colors.green[800],
                          child: Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: Image.asset(
                              'lib/images/bomberman.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      } else if (barriers.contains(index)) {
                        return const MyPixel(
                          innerColor: Colors.black,
                          outerColor: Colors.black,
                        );
                      } else if (boxes.contains(index)) {
                        return MyPixel(
                          innerColor: Colors.brown,
                          outerColor: Colors.brown[800],
                        );
                      } else {
                        return MyPixel(
                          innerColor: Colors.green,
                          outerColor: Colors.green[800],
                        );
                      }
                    })
                : win == true
                    ? Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Congratulations',
                                    style: TextStyle(
                                      color: Colors.green[200],
                                      fontSize: 40,
                                    ),
                                  )
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'You Win!',
                                    style: TextStyle(
                                      color: Colors.green[400],
                                      fontSize: 40,
                                    ),
                                  )
                                ]),
                            const SizedBox(height: 20),
                            InkWell(
                              onTap: reset,
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'Reset',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 40,
                                      ),
                                    ),
                                    Icon(
                                      Icons.refresh,
                                      size: 40,
                                      color: Colors.white,
                                    )
                                  ]),
                            ),
                          ],
                        ),
                      )
                    : loose == true
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Sorry',
                                        style: TextStyle(
                                          color: Colors.red[200],
                                          fontSize: 40,
                                        ),
                                      )
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'You Loose!',
                                        style: TextStyle(
                                          color: Colors.red[400],
                                          fontSize: 40,
                                        ),
                                      )
                                    ]),
                                const SizedBox(height: 20),
                                InkWell(
                                  onTap: reset,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Text(
                                          'Reset',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 40,
                                          ),
                                        ),
                                        Icon(
                                          Icons.refresh,
                                          size: 40,
                                          color: Colors.white,
                                        )
                                      ]),
                                ),
                              ],
                            ),
                          )
                        : const SizedBox(),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyButton(),
                    MyButton(
                      function: moveUp,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.arrow_drop_up,
                        size: 70,
                      ),
                    ),
                    const MyButton(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyButton(
                      function: moveLeft,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.arrow_left,
                        size: 70,
                      ),
                    ),
                    MyButton(
                      function: placeBomb,
                      color: Colors.grey[900],
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          'lib/images/pokeball.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    MyButton(
                      function: moveRight,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.arrow_right,
                        size: 70,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyButton(),
                    MyButton(
                      function: moveDown,
                      color: Colors.grey,
                      child: const Icon(
                        Icons.arrow_drop_down,
                        size: 70,
                      ),
                    ),
                    const MyButton(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
