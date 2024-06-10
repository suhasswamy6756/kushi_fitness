import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:kushi_3/pages/Fragments/mainFragments/redeemScreen.dart';
import 'package:kushi_3/service/firestore_service.dart';
import 'package:kushi_3/service/fitness/fetch_details.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as developer;


FirestoreService _firestoreService = FirestoreService();


class ActivityFragment extends StatefulWidget {
  const ActivityFragment({super.key});

  @override
  State<ActivityFragment> createState() => _ActivityFragmentState();
}

class _ActivityFragmentState extends State<ActivityFragment> {
//  FirestoreService _firestoreService = FirestoreService();
  // List<double> weeklySummary = [4.40, 2.50, 42.42, 30, 50, 96, 59];
  late int _steps = 0;
  late int remainingSteps = 0;
  var coins = 0;
  late var percentage;
  final FirestoreService _firestoreService = FirestoreService();
  final FitnessDetails _fit = FitnessDetails();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initializeSteps();
    _initializeCoins();
    print(globals.initial5000StepsToken);

  }

  Future<void> _initializeSteps() async {
    try {
      int steps = await _fit.fetchTotalSteps();
      setState(() {
        _steps = steps;
        globals.stepsToday = steps;
        globals.countedSteps = steps;
        // globals.initial5000StepsToken = false; // Initialize to false
      });

      await getCoins();

    } catch (e) {
      // Handle any potential exceptions
      print('Error initializing steps: $e');
      setState(() {
        _steps = 0; // Set a default value
      });
    }
  }
  Future<void> _initializeCoins() async {
    try {
      int fortyTokens = await globals.get40CoinNumber(_firestoreService.getCurrentUserId());
      int twentyTokens = await globals.get20CoinNumber(_firestoreService.getCurrentUserId());
      int tenTokens = await globals.get10CoinNumber(_firestoreService.getCurrentUserId());
      int totalCoins = fortyTokens * 40 + twentyTokens * 20 + tenTokens * 10;
      setState(() {
        this.coins = totalCoins;
      });
    } catch (e) {
      print('Error initializing coins: $e');
      setState(() {
        coins = 10;
      });
    }
  }



  Future<List<int>> getCoins() async {
    var stepsNow = globals.stepsToday;
    var curDate = DateFormat('yyyyMMdd').format(DateTime.now()).toString();

    print('Current steps: $stepsNow');
    print('Current date: $curDate');
    print('Daily token status: ${globals.dailyToken}');
    print('Initial 5000 steps token status: ${globals.initial5000StepsToken}');
    print('Counted steps: ${globals.countedSteps}');

    // Check if a 40-rupee token should be generated for 10,000 steps on a new day
    if (stepsNow >= 10000 && curDate != globals.date) {
      if (!globals.dailyToken) {
        print('Generating 40-rupee token');
        globals.date = curDate;
        globals.generate40RupeeToken(_firestoreService.getCurrentUserId());
        globals.countedSteps -= 10000;
        setState(() {
          globals.dailyToken = true;

        });
      }
    }

    // Check if a 20-rupee token should be generated for the initial 5000 steps
    if (stepsNow >= 5000 && !globals.initial5000StepsToken) {
      print('Generating initial 20-rupee token');
      globals.generate20RupeeToken(_firestoreService.getCurrentUserId());
      globals.countedSteps -= 5000;
      setState(() {
        globals.initial5000StepsToken = true;

      });
    }

    // Generate additional 20-rupee tokens for every 5000 steps beyond the initial 5000 steps
    while (globals.countedSteps >= 5000) {
      print('Generating additional 20-rupee token');
      globals.generate20RupeeToken(_firestoreService.getCurrentUserId());
      globals.countedSteps -= 5000;
    }

    // Fetch the number of 40 and 20 rupee tokens
    try {
      int fortytokens = await globals.get40CoinNumber(_firestoreService.getCurrentUserId());
      int twentyTokens = await globals.get20CoinNumber(_firestoreService.getCurrentUserId());
      print('40-rupee tokens: $fortytokens');
      print('20-rupee tokens: $twentyTokens');
      return [fortytokens, twentyTokens];
    } catch (e) {
      print('Error fetching tokens: $e');
      return [0, 0]; // Return default values in case of error
    }
  }




  Future<String?> totalCoins() async {
    int fortytokens =
        await globals.get40CoinNumber(_firestoreService.getCurrentUserId());
    int twentyTokens =
        await globals.get20CoinNumber(_firestoreService.getCurrentUserId());
    return "40×$fortytokens 20×$twentyTokens";
  }


  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    int newSteps = await _fit.fetchTotalSteps();
    setState(() {
      _steps = newSteps;
      globals.stepsToday = newSteps;
      // globals.stepsToday = newSteps;
    });
    await getCoins();

  }


  double? valueIndicator(int Steps) {
    return Steps / 10000;
  }

  int? remainSteps(int Steps) {
    return 10000 - Steps;
  }

  @override
  Widget build(BuildContext context) {
    remainingSteps = 10000 - _steps;
    percentage = _steps / 100;

    return Scaffold(
        body: RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(children: [
                            Image.asset(
                              'assets/Frame.png',
                              height: 150,
                              width: 150,
                            )
                          ]),
                          Container(
                            margin: const EdgeInsets.only(left: 40, top: 30),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "You're off to a",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                    textAlign: TextAlign.left,
                                  ),
                                  const Text(
                                    "great start!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                    textAlign: TextAlign.left,
                                  ),
                                  const Text(
                                    "Steps left to defeat!",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey,
                                        fontSize: 15),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "$remainingSteps",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                    textAlign: TextAlign.left,
                                  ),
                                ]),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Center(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: LinearProgressIndicator(
                                  value: valueIndicator(_steps),
                                  minHeight: 10,
                                  backgroundColor: Colors.green[100],
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: const Text(
                            '🎁',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10, bottom: 20),
                      child: Row(
                        children: [
                          Text('$_steps steps done'),
                          const SizedBox(
                            width: 170,
                          ),
                          const Text('Goal 10000')
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const redeemScreen()),
                        );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 50, bottom: 50, left: 32, right: 32),
                        child: Column(
                          children: [
                            const Text(
                              'My Rewards',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            FutureBuilder(
                                future: totalCoins(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    );
                                  } else {
                                    return const Text(
                                      'No data',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    );
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/referalLink');
                    },
                    child: Card(
                      color: const Color.fromRGBO(32, 38, 49, 1),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 50, bottom: 50, left: 5, right: 5),
                        child: const Text(
                          'Invite Your friends\n and earn rewards',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.white),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Redeem',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(59, 59, 59, 1),
                  ),
                  textAlign: TextAlign.left,
                ),
                Stack(
                  children: [
                    Container(
                      height: 190,
                      width: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(232, 232, 232, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(
                            textAlign: TextAlign.left,
                            'Sports accessories',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      height: 190,
                      width: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(232, 232, 232, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(
                            textAlign: TextAlign.left,
                            'Sports accessories',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  children: [
                    Container(
                      height: 190,
                      width: 360,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.green,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(232, 232, 232, 1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: const Text(
                            textAlign: TextAlign.left,
                            'Sports accessories',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
