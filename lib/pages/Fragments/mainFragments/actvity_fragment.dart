import 'package:flutter/material.dart';
import 'package:kushi_3/service/fitness/fetch_details.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:intl/intl.dart';
import 'dart:developer' as dev;

class ActivityFragment extends StatefulWidget {
  const ActivityFragment({super.key});

  @override
  State<ActivityFragment> createState() => _ActivityFragmentState();
}

class _ActivityFragmentState extends State<ActivityFragment> {
  List<double> weeklySummary = [4.40, 2.50, 42.42, 30, 50, 96, 59];
  late int _steps = 0;
  late int remainingSteps = 0;
  int fortytokens=0;
  int twentytokens=0;
  late var percentage;

  final FitnessDetails _fit = FitnessDetails();

  @override
  void initState() {
    resetDailyCoin();
    runCoinFetching();
    super.initState();
    _initializeSteps();
  }


  void resetDailyCoin() async{

    var curDate = DateFormat('MMDDYY')
        .format(DateTime.now())
        .toString();
    if(curDate != globals.date){
      globals.dailyToken = false;
    }
  }

  void runCoinFetching() async{
    dev.log(globals.uid.toString());
    var stepsNow = globals.stepsToday;
    dev.log(globals.dailyToken.toString());
    var curDate = DateFormat('MMDDYY')
        .format(DateTime.now())
        .toString();
    dev.log(globals.countedSteps.toString());
    if(curDate != globals.date){
      globals.countedSteps = 0;
      globals.lastSteps = 0;
      globals.date = curDate;
    }
    dev.log(globals.stepsToday.toString());
    if (stepsNow >= 10000 && curDate != globals.date){
      if (globals.dailyToken == false){
        globals.generate40RupeeToken();
        globals.dailyToken = true;
      }
    }
    else if(globals.dailyToken == false && stepsNow >= 10000){
      globals.generate40RupeeToken();
      globals.dailyToken = true;
    }
    else {
      if (globals.lastSteps != globals.stepsToday && stepsNow >= 10000) {
        globals.countedSteps += globals.stepsToday - globals.lastSteps;
        globals.lastSteps = globals.stepsToday;
      }
      while (globals.countedSteps > 5000) {
        globals.generate20RupeeToken();
        globals.countedSteps -= 5000;
      }
    }
    fortytokens = await globals.get40CoinNumber();
    twentytokens = await globals.get20CoinNumber();
    setState(() {});
  }

  Future<void> _initializeSteps() async {
    try {
      int steps = await _fit.fetchTotalSteps();
      setState(() {
        _steps = steps;
      });
    } catch (e) {
      // Handle any potential exceptions
      print('Error initializing steps: $e');
      setState(() {
        _steps = 0; // Set a default value
      });
    }
  }
  Future<void> _refreshData() async {
    setState(() {
      _steps = 0;
    });
    await Future.delayed(const Duration(seconds: 1));
    int newSteps = await _fit.fetchTotalSteps();
    setState(() {
      _steps = newSteps;
    });
  }


  double? valueIndicator(int Steps) {
    return Steps / 10000;
  }

  int? remainSteps(int Steps) {
    return 10000 - Steps;
  }

  @override
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
                elevation: 4, // Adjust the elevation as needed
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      16), // Adjust the border radius as needed
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Image and Text Row
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(

                              children: [
                            Image.asset(
                              'assets/Frame.png',
                              height: 150,
                              width: 150,
                            )
                          ]),

                          // SizedBox(width: 16), // Add some space between the image and text
                          // Text on the right
                          Container(
                            margin: const EdgeInsets.only(left: 40,top: 30),
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
                    // Linear Progress Indicator
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
                                  valueColor: const AlwaysStoppedAnimation<Color>(
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
                // Adjust the alignment as needed
                children: [
                  // First Card
                  GestureDetector(
                    onTap: (){},
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
                            SizedBox(height: 30,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the value as needed
                                border: Border.all(color: Colors.black), // Optional border color
                                color: Colors.transparent, // Optional, if you want to set a background color
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(8), // Adjust padding as needed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10), // Adjust the value as needed
                                      color: Colors.purple,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '40',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Text(
                                    'x$fortytokens',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 10,)
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), // Adjust the value as needed
                                border: Border.all(color: Colors.black), // Optional border color
                                color: Colors.transparent, // Optional, if you want to set a background color
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [// Adjust spacing between the two containers
                                  Container(
                                    padding: EdgeInsets.all(8), // Adjust padding as needed
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10), // Adjust the value as needed
                                      color: Colors.green,
                                    ),
                                    child: Text(
                                      '20',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  SizedBox(width: 10,),
                                  Text(
                                    'x$twentytokens',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(width: 10,)
                                ],
                              ),
                            )

                          ],
                        ),
                      ),
                    ),
                  ),
                  // Add some space between the cards
                  // SizedBox(width: 20),
                  // Second Card
                  Card(
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
                      // Adjust this value to change the distance from the bottom
                      left: 0,
                      right: 0,
                      child: Container(
                        // alignment: Alignment.center,
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
                      // Adjust this value to change the distance from the bottom
                      left: 0,
                      right: 0,
                      child: Container(
                        // alignment: Alignment.center,
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
                      // Adjust this value to change the distance from the bottom
                      left: 0,
                      right: 0,
                      child: Container(
                        // alignment: Alignment.center,
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
                // SizedBox(height: 30,)
              ],
            )
          ],
                ),
              ),
        ));
  }
}
