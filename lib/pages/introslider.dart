
import 'package:flutter/material.dart';
import 'package:kushi_3/pages/signin.dart';
import 'package:kushi_3/pages/signup.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroSlider extends StatefulWidget {
  const IntroSlider({super.key});

  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  isLastPage = index == 1;
                });
              },
              children: const [
                BuildIntroPage(
                  title: "Workout Categories",
                  description: 'Workout categories will help you gain '
                      'strength, get in better shape and embrace '
                      'a healthy lifestyle',
                ),
                BuildIntroPage(
                  title: "Workout Categories",
                  description: 'Workout categories will '
                      'help you gain '
                      'strength, get in better shape and embrace '
                      'a healthy lifestyle',
                ),
              ],
            ),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: _controller,
              count: 2,
              onDotClicked: (index) {
                _controller.animateToPage(index,
                    duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
              },
              effect: const ExpandingDotsEffect(
                activeDotColor: Colors.black,
                dotWidth: 10,
                dotHeight: 10,
                dotColor: Colors.black12,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                elevation: 10,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              onPressed: isLastPage
                  ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder:(context){
                    return SignUp();
                  })
                );
              }
                  : () {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                );
              },
              child: Text(
                isLastPage ? 'Start Training' : "Next",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30),
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return SignIn();
                  }),
                );
              },
              child: const Text(
                "Already have an account?",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class BuildIntroPage extends StatelessWidget {
  final String title;
  final String description;

  const BuildIntroPage({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 34,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            description,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
            softWrap: true,
            maxLines: 3,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
