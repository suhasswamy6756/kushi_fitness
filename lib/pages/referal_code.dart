import 'package:flutter/material.dart';
import 'package:kushi_3/components/mybutton.dart';
import 'package:kushi_3/pages/selectGender.dart';

class ReferralScreen extends StatefulWidget {
  const ReferralScreen({super.key});

  @override
  _ReferralScreenState createState() => _ReferralScreenState();
}

class _ReferralScreenState extends State<ReferralScreen> {
  final TextEditingController _referralController = TextEditingController();

  @override
  void dispose() {
    _referralController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Referral Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _referralController,
              decoration: const InputDecoration(
                labelText: 'Enter Referral Code',
              ),
            ),
            const SizedBox(height: 20),
            MyButton(text: 'Continue', onTap: (){

            }),
            const SizedBox(height: 50,),
            TextButton(
              onPressed: () {
                // Implement your logic for continuing without referral here
                // For example, navigate to the next screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SelectGender(),
                  ),
                );
              },
              child: const Text('No referral? Continue instead'),
            ),
          ],
        ),
      ),
    );
  }
}
