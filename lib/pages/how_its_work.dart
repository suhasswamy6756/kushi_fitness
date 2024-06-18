import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HowItsWork extends StatelessWidget {
  const HowItsWork({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text(
        "How it’s work ?",
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 19,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), // Back arrow icon
        onPressed: () {
          Navigator.of(context).pop(); // Navigate back when pressed
        },
      ),
    ));
  }
}
