// import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:kushi_3/components/bar_graph/single_bar_graph.dart';
import 'package:kushi_3/service/fitness/fetch_details.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  // final int _stepPer = 30;
  late var _steps = 0;

  FitnessDetails _fit = FitnessDetails();

  @override
  void initState() {
    super.initState();
    _initializeSteps();
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
    await Future.delayed(Duration(seconds: 1));
    int newSteps = await _fit.fetchTotalSteps();
    setState(() {
      _steps = newSteps;
    });
  }

  @override
  Widget build(BuildContext context) {
    double percentage = _steps / 100;

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          // Wrap your Column with SingleChildScrollView
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 25, right: 25, top: 25, bottom: 10),
                height: 200,
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(232, 232, 232, 1),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10, right: 45.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Daily",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              "challenge",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ]),
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          'assets/Ellipse.png',
                        ),
                        Image.asset('assets/first_page.png'),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text(
                      '$_steps',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      // padding:EdgeInsets.only(left: 10,right: 10) ,
                      height: 10,
                      // Adjust the height of the linear progress indicator container
                      color: Colors.transparent,
                      // Transparent color to overlay the linear progress indicator
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: percentage / 100,
                            // Set the progress value between 0.0 and 1.0
                            minHeight: 10,
                            // Set the height of the linear progress indicator
                            backgroundColor: Colors.green[100],
                            // Set the background color of the linear progress indicator
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors
                                .green), // Set the color of the linear progress indicator
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '$percentage%',
                      style: const TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 30, right: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        '200 calories',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      // padding:EdgeInsets.only(left: 10,right: 10) ,
                      height: 10,
                      // Adjust the height of the linear progress indicator container
                      color: Colors.transparent,
                      // Transparent color to overlay the linear progress indicator
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: 0.5,
                            // Set the progress value between 0.0 and 1.0
                            minHeight: 10,
                            // Set the height of the linear progress indicator
                            backgroundColor: Colors.blue[100],
                            // Set the background color of the linear progress indicator
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors
                                .blue), // Set the color of the linear progress indicator
                          ),
                        ),
                      ),
                    ),
                    Text(
                      'add',
                      style: const TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    )
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
                            margin: EdgeInsets.only(left: 20),
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
                  SizedBox(
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
                            margin: EdgeInsets.only(left: 20),
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
                  SizedBox(
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
                            margin: EdgeInsets.only(left: 20),
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
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    // Define your custom shape here using various path operations
    path.moveTo(0, 10 * 0.5); // Move to starting point
    path.lineTo(10 * 0.4, 0); // Draw a line to create the shape
    path.lineTo(10, 10 * 0.2); // Draw another line
    path.lineTo(10, 10); // Draw another line
    path.lineTo(0, 10); // Draw another line to complete the shape
    path.close(); // Close the path
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class IrregularShapeBackgroundImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Irregular Shape Background Image'),
      ),
      body: Center(
        child: Stack(
          children: [
            ClipPath(
              clipper: CustomShapeClipper(),
              child: Container(
                color: Colors.blue, // Background color of the irregular shape
                width: 100, // Adjust width as needed
                height: 100, // Adjust height as needed
              ),
            ),
            Positioned.fill(
              child: ClipPath(
                clipper: CustomShapeClipper(),
                child: Image.asset(
                  'assets/first_page.png', // Your image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
