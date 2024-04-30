import 'package:flutter/material.dart';
import 'package:kushi_3/components/bar_graph/bar_graph.dart';

class ActivityFragment extends StatefulWidget {
  const ActivityFragment({super.key});

  @override
  State<ActivityFragment> createState() => _ActivityFragmentState();
}

class _ActivityFragmentState extends State<ActivityFragment> {
  List<double> weeklySummary = [4.40, 2.50, 42.42, 30, 50, 96, 59];
  var _steps = 2000;
  int? remainingSteps= 0;
  
  double? valueIndicator(int Steps){
    return Steps/10000;
  }
  int? remainSteps(int Steps){
    return 10000-Steps;
  }
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Card(
              elevation: 4, // Adjust the elevation as needed
              shape: RoundedRectangleBorder(
                
                borderRadius: BorderRadius.circular(16), // Adjust the border radius as needed
              ),
            
            
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Image and Text Row
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image on the left
                        Image.asset(
                          'assets/first_page.png',
                          width: 80, // Adjust the width as needed
                          height: 80, // Adjust the height as needed
                          fit: BoxFit.cover, // Adjust the fit as needed
                        ),
                        SizedBox(width: 16), // Add some space between the image and text
                        // Text on the right
                        Container(
                          margin: EdgeInsets.only(left: 90),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("You're off to a",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text("great start!",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20
                                ),
                                textAlign: TextAlign.left,
            
                              ),
                              Text("Steps left to defeat!",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                    fontSize: 15
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text("$_steps",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    
                                    fontSize: 20
                                ),
                                textAlign: TextAlign.left,
                              ),

                            ]
            
                          ),
                        )
                      ],
                    ),
                  ),
                  // Linear Progress Indicator
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                value: valueIndicator(_steps),
                                minHeight: 10,
                                backgroundColor: Colors.green[100],
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Text(
                          '🎁',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10,bottom: 20),
                    child: Row(
                      
                      children: [
                        Text('1000 steps done'),
                        SizedBox(width: 170,),
                        Text('Goal 10000')
                      ],
                    ),
                  )




                ],
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Adjust the alignment as needed
              children: [
                // First Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(

                    margin: EdgeInsets.only(top: 60,bottom: 60,left: 5,right: 5),
                    child: Text(
                      'My Rewards',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                // Add some space between the cards
                // SizedBox(width: 20),
                // Second Card
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: 60,bottom: 60,left: 5,right: 5),
                    child: Text(
                      'First Card Content',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )

        ],
      )
    );
  }
}
