import 'package:flutter/material.dart';
import 'package:kushi_3/pages/Fragments/mainFragments/redeemScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kushi_3/service/fitness/fetch_details.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  late var _steps = 0;

  final FitnessDetails _fit = FitnessDetails();

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
    await Future.delayed(const Duration(seconds: 1));
    int newSteps = await _fit.fetchTotalSteps();
    setState(() {
      _steps = newSteps;
    });
  }

  @override
  Widget build(BuildContext context) {
    double percentage = _steps / 10000.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: SingleChildScrollView(
          // Wrap your Column with SingleChildScrollView
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 10),
                height: 200,
                width: 360,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(232, 232, 232, 1),
                ),
                child: Row(
                  children: [
                    const Padding(
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
                          ),
                        ],
                      ),
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          'assets/Ellipse.png',
                        ),
                        Image.asset('assets/first_page.png'),
                      ],
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
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 10,
                      color: Colors.transparent,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: percentage,
                            minHeight: 10,
                            backgroundColor: Colors.green[100],
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '${(percentage * 100).toStringAsFixed(1)}%',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
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
                        '200 calories',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 10,
                      color: Colors.transparent,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: 0.5,
                            minHeight: 10,
                            backgroundColor: Colors.blue[100],
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
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
                  Text(
                    'Redeem',
                    style: GoogleFonts.poppins(
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
                            image: const DecorationImage(
                              image: AssetImage("assets/home/decathlon.png"),
                              fit: BoxFit.cover,
                            ),
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
                            padding: const EdgeInsets.only(left: 20),
                            child: const Text(
                              'Decathlon',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 20),
                  Stack(
                    children: [
                      Container(
                        height: 190,
                        width: 360,
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage("assets/home/nike.png"),
                            fit: BoxFit.fill,
                          ),
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
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'Nike',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
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
                          padding: const EdgeInsets.only(left: 20),
                          child: const Text(
                            'Sports accessories',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
  const IrregularShapeBackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Irregular Shape Background Image'),
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
