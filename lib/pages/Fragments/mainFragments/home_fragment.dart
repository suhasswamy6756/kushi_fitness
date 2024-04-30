import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kushi_3/components/bar_graph/single_bar_graph.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final int _steps = 300;
  final int _stepPer = 30;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
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
              child: const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
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
                      '$_steps Steps',
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
                          backgroundColor: Colors.green[100],
                          // Set the background color of the linear progress indicator
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors
                              .green), // Set the color of the linear progress indicator
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '$_stepPer%',
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
                      '$_steps calories',
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
                    '${_stepPer}%',
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
                SizedBox(height: 20,),
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
                SizedBox(height: 20,),
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
    );
  }
}
