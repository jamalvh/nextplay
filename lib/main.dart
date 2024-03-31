import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

bool accepted = false;
String sel = "Null";
List<String> opps = ["Run", "Pass", "Touchdown"];
List<int> oppsPts = [0, 0, 0];
List<String> playOptions = [
  'Touchdown',
  'Turnover',
  'First Down',
  'Sack',
  'Run',
  'Pass'
];
List<String> myCards = ["Touchdown", "First Down", "Pass", "First Down"];
int myPts = 0;
List<bool> winners = [false, false, false, false]; // 4 is you

class _MyHomePageState extends State<MyHomePage> {
  // ignore: prefer_typing_uninitialized_variables
  var _chosenValue;

  @override
  void initState() {
    shuffleOpps();
    shuffleMyCards(sel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
        title: const Text("Next Play",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic)),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.grey[50],
                child: SizedBox(
                  height: 350,
                  width: 250,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Live Zone",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DropdownButton(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          value: _chosenValue,
                          //elevation: 5,
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                          items: [
                            'Touchdown',
                            'Turnover',
                            'First Down',
                            'Sack',
                            'Run',
                            'Pass',
                          ].map((String value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          hint: const Text(
                            "Highest Play?",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _chosenValue = value;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FilledButton(
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.blue,
                            ),
                          ),
                          onPressed: () {
                            if (_chosenValue != null && sel != "Null") {
                              decideWinner();
                              showLosePopup();
                            }
                          },
                          child: const Text("End of Play"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "You have $myPts pts",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 25,
              ),
              DragTarget(
                onAccept: (data) {
                  setState(() {
                    accepted = true;
                    sel = data.toString();
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return accepted
                      ? Card(
                          elevation: 1,
                          color: Colors.yellow[50],
                          child: SizedBox(
                            height: 350,
                            width: 250,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 75),
                                  const Text(
                                    "Play",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        decoration: TextDecoration.underline),
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  Text(
                                    sel,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const Card(
                          elevation: 0,
                          color: Colors.black26,
                          child: SizedBox(
                            height: 350,
                            width: 250,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Your Card",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "(Drag here)",
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                },
              ),

              const SizedBox(
                width: 55,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Player 1 (${oppsPts[0]} pts)",
                    style: TextStyle(
                        color: Colors.red[200], fontWeight: FontWeight.bold),
                  ),
                  Card(
                    color: Colors.red[50],
                    child: SizedBox(
                      height: 250,
                      width: 150,
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Play",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Text(
                              opps[0],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Player 2 (${oppsPts[1]} pts)",
                    style: TextStyle(
                      color: Colors.blue[200],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Card(
                    color: Colors.blue[50],
                    child: SizedBox(
                      height: 250,
                      width: 150,
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Play",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Text(
                              opps[1],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 5,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Player 3 (${oppsPts[2]} pts)",
                    style: TextStyle(
                      color: Colors.green[200],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Card(
                    color: Colors.green[50],
                    child: SizedBox(
                      height: 250,
                      width: 150,
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            const Text(
                              "Play",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontStyle: FontStyle.italic,
                                  decoration: TextDecoration.underline),
                            ),
                            const SizedBox(
                              height: 45,
                            ),
                            Text(
                              opps[2],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(
                width: 25,
              ),
              // const SizedBox(width: 750),
              const SizedBox(width: 12),
              Card(
                color: Colors.grey[50],
                child: const SizedBox(
                  height: 350,
                  width: 250,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tiebreaker",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "1. Touchdown",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "2. Turnover",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "3. First Down",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "4. Sack",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "5. Run",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              "6. Pass",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Draggable(
                data: myCards[0],
                feedback: Card(
                  color: Colors.grey[50],
                  child: SizedBox(
                    height: 325,
                    width: 225,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "Play",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            myCards[0],
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                childWhenDragging: const Card(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  child: SizedBox(
                    height: 325,
                    width: 225,
                  ),
                ),
                child: Card(
                  color: Colors.grey[50],
                  child: SizedBox(
                    height: 325,
                    width: 225,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "Play",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            myCards[0],
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Draggable(
                data: myCards[1],
                feedback: Card(
                  color: Colors.grey[50],
                  child: SizedBox(
                    height: 325,
                    width: 225,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "Play",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            myCards[1],
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                childWhenDragging: const Card(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  child: SizedBox(
                    height: 325,
                    width: 225,
                  ),
                ),
                child: Card(
                  color: Colors.grey[50],
                  child: SizedBox(
                    height: 325,
                    width: 225,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "Play",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            myCards[1],
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Draggable(
                data: myCards[2],
                feedback: Card(
                  color: Colors.grey[50],
                  child: SizedBox(
                    height: 325,
                    width: 225,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "Play",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            myCards[2],
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                childWhenDragging: const Card(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  child: SizedBox(
                    height: 325,
                    width: 225,
                  ),
                ),
                child: Card(
                  color: Colors.grey[50],
                  child: SizedBox(
                    height: 325,
                    width: 225,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "Play",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            myCards[2],
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Draggable(
                data: myCards[3],
                feedback: Card(
                  color: Colors.grey[50],
                  child: SizedBox(
                    height: 325,
                    width: 225,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "Play",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            myCards[3],
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                childWhenDragging: const Card(
                  shadowColor: Colors.transparent,
                  color: Colors.transparent,
                  child: SizedBox(
                    height: 325,
                    width: 225,
                  ),
                ),
                child: Card(
                  color: Colors.grey[50],
                  child: SizedBox(
                    height: 325,
                    width: 225,
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 60,
                          ),
                          const Text(
                            "Play",
                            style: TextStyle(
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                                decoration: TextDecoration.underline),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          Text(
                            myCards[3],
                            style: const TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void shuffleOpps() {
    var rng = Random();
    for (int i = 0; i < 3; i++) {
      opps[i] = playOptions[rng.nextInt(6)];
    }
    setState(() {});
  }

  void shuffleMyCards(String selected) {
    var rng = Random();
    if (selected != "Null") {
      for (int i = 0; i < 4; i++) {
        if (selected == myCards[i]) {
          myCards[i] = playOptions[rng.nextInt(6)];
          break;
        }
      }
    } else {
      for (int i = 0; i < 4; i++) {
        myCards[i] = playOptions[rng.nextInt(6)];
      }
    }
    setState(() {});
  }

  decideWinner() {
    for (int i = 0; i < 3; i++) {
      if (opps[i] == _chosenValue) {
        oppsPts[i] += 1;
        winners[i] = true;
      }
    }
    if (sel == _chosenValue) {
      myPts += 1;
      winners[3] = true;
    }
    setState(() {});
  }

  void nextRound() {
    for (int i = 0; i < 4; i++) {
      winners[i] = false;
    }
    shuffleOpps();
    shuffleMyCards(sel);
    accepted = false;
    sel = "Null";
    setState(() {
      _chosenValue = null;
    });
  }

  bool noWinners() {
    for (int i = 0; i < 4; i++) {
      if (winners[i] == true) {
        return false;
      }
    }
    return true;
  }

  showLosePopup() {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          width: 200,
          color: Colors.transparent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                winners[0]
                    ? Text(
                        "Player 1 Won the Play!",
                        style: TextStyle(
                            color: Colors.red[50],
                            decoration: TextDecoration.none,
                            fontSize: 30),
                      )
                    : Container(),
                winners[1]
                    ? Text(
                        "Player 2 Won the Play!",
                        style: TextStyle(
                            color: Colors.blue[50],
                            decoration: TextDecoration.none,
                            fontSize: 30),
                      )
                    : Container(),
                winners[2]
                    ? Text(
                        "Player 3 Won the Play!",
                        style: TextStyle(
                            color: Colors.green[50],
                            decoration: TextDecoration.none,
                            fontSize: 30),
                      )
                    : Container(),
                winners[3]
                    ? Text(
                        "You Won the Play!",
                        style: TextStyle(
                            color: Colors.yellow[50],
                            decoration: TextDecoration.none,
                            fontSize: 30),
                      )
                    : Container(),
                noWinners()
                    ? const Text("Nobody Won the Play!",
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.none,
                            fontSize: 30))
                    : Container(),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                    nextRound();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.grey[50]),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    elevation: const MaterialStatePropertyAll(0),
                  ),
                  child: const Text(
                    "Next Round",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
