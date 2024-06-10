import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:kushi_3/service/firestore_service.dart';
import 'package:kushi_3/service/fitness/fetch_details.dart';
import 'dart:developer' as developer;

FirestoreService _firestoreService = FirestoreService();

class ActivityFragment extends StatefulWidget {
  const ActivityFragment({super.key});

  @override
  State<ActivityFragment> createState() => _ActivityFragmentState();
}

class _ActivityFragmentState extends State<ActivityFragment> {
  FirestoreService _firestoreService = FirestoreService();
  late int _steps = 0;
  late int remainingSteps = 0;
  var coins = 10;
  late var percentage;

  final FitnessDetails _fit = FitnessDetails();

  @override
  void initState() {
    super.initState();
    _initializeSteps();
    print(globals.initial5000StepsToken);
  }

  Future<void> _initializeSteps() async {
    try {
      int steps = await _fit.fetchTotalSteps();
      setState(() {
        _steps = steps;
        globals.stepsToday = steps;
        globals.countedSteps = steps;
      });
      await getCoins();
    } catch (e) {
      print('Error initializing steps: $e');
      setState(() {
        _steps = 0;
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

    if (stepsNow >= 5000 && !globals.initial5000StepsToken) {
      print('Generating initial 20-rupee token');
      globals.generate20RupeeToken(_firestoreService.getCurrentUserId());
      globals.countedSteps -= 5000;
      setState(() {
        globals.initial5000StepsToken = true;
      });
    }

    while (globals.countedSteps >= 5000) {
      print('Generating additional 20-rupee token');
      globals.generate20RupeeToken(_firestoreService.getCurrentUserId());
      globals.countedSteps -= 5000;
    }

    try {
      int fortytokens = await globals.get40CoinNumber(_firestoreService.getCurrentUserId());
      int twentyTokens = await globals.get20CoinNumber(_firestoreService.getCurrentUserId());
      print('40-rupee tokens: $fortytokens');
      print('20-rupee tokens: $twentyTokens');
      return [fortytokens, twentyTokens];
    } catch (e) {
      print('Error fetching tokens: $e');
      return [0, 0];
    }
  }

  Future<String?> totalCoins() async {
    int fortytokens = await globals.get40CoinNumber(_firestoreService.getCurrentUserId());
    int twentyTokens = await globals.get20CoinNumber(_firestoreService.getCurrentUserId());
    return "40×$fortytokens 20×$twentyTokens";
  }

  Future<void> _refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    int newSteps = await _fit.fetchTotalSteps();
    setState(() {
      _steps = newSteps;
      globals.stepsToday = newSteps;
    });
    await getCoins();
  }

  double? valueIndicator(int steps) {
    return steps / 10000;
  }

  int? remainSteps(int steps) {
    return 10000 - steps;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double horizontalPadding = screenWidth * 0.05;

    remainingSteps = 10000 - _steps;
    percentage = _steps / 100;

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(screenWidth * 0.03),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: horizontalPadding),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(children: [
                              Image.asset(
                                'assets/Frame.png',
                                height: screenHeight * 0.2,
                                width: screenWidth * 0.4,
                              )
                            ]),
                            Container(
                              margin: EdgeInsets.only(left: screenWidth * 0.1, top: screenHeight * 0.04),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "You're off to a",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.05,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "great start!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.05,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "Steps left to defeat!",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                      fontSize: screenWidth * 0.04,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  Text(
                                    "$remainingSteps",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: screenWidth * 0.05,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: horizontalPadding),
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: LinearProgressIndicator(
                                    value: valueIndicator(_steps),
                                    minHeight: 10,
                                    backgroundColor: Colors.green[100],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.green,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(screenWidth * 0.015),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Text(
                              '🎁',
                              style: TextStyle(fontSize: screenWidth * 0.05),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: horizontalPadding, bottom: screenHeight * 0.03),
                        child: Row(
                          children: [
                            Text('$_steps steps done'),
                            Spacer(),
                            Text('Goal 10000'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.06,
                            horizontal: screenWidth * 0.08,
                          ),
                          child: Column(
                            children: [
                              Text(
                                'My Rewards',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: screenWidth * 0.045,
                                ),
                              ),
                              FutureBuilder(
                                future: totalCoins(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return CircularProgressIndicator();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    return Text(
                                      snapshot.data ?? '',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    );
                                  } else {
                                    return Text(
                                      'No data',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.045,
                                      ),
                                    );
                                  }
                                },
                              ),
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
                          padding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.06,
                            horizontal: screenWidth * 0.04,
                          ),
                          child: Text(
                            'Invite Your friends\nand earn rewards',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.045,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Redeem',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(59, 59, 59, 1),
                      ),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    _buildRedeemCard('Sports accessories'),
                    SizedBox(height: screenHeight * 0.02),
                    _buildRedeemCard('Sports accessories'),
                    SizedBox(height: screenHeight * 0.02),
                    _buildRedeemCard('Sports accessories'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRedeemCard(String text) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Container(
          height: screenHeight * 0.25,
          width: screenWidth * 0.9,
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
            decoration: BoxDecoration(
              color: Color.fromRGBO(232, 232, 232, 1),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Container(
              margin: EdgeInsets.only(left: screenWidth * 0.05),
              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: screenWidth * 0.045,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
