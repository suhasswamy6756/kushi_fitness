import 'package:flutter/material.dart';
import 'package:kushi_3/model/SpendCoin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:kushi_3/service/firestore_service.dart';

class redeemScreen extends StatefulWidget {
  const redeemScreen({Key? key}) : super(key: key);

  @override
  _RedeemScreenState createState() => _RedeemScreenState();
}

class _RedeemScreenState extends State<redeemScreen> {
  int availableCoins = 100; // Example value, replace with actual data
  final TextEditingController _controller = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();
  final SpendCoin _spendCoin = SpendCoin();
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchAvailableCoins();
  }

  Future<void> _fetchAvailableCoins() async {
    try {
      int fortyTokens = await globals.get40CoinNumber(
          _firestoreService.getCurrentUserId());
      int twentyTokens = await globals.get20CoinNumber(
          _firestoreService.getCurrentUserId());
      int tenTokens = await globals.get10CoinNumber(
          _firestoreService.getCurrentUserId());
      int totalCoins = fortyTokens * 40 + twentyTokens * 20 + tenTokens * 10;
      setState(() {
        availableCoins = totalCoins;
      });
    } catch (e) {
      _showPopup(context, 'Failed to fetch available coins: $e');
    }
  }
    Future<void> _redeemCoins() async {
      int redeemAmount = int.tryParse(_controller.text) ?? 0;
      if (redeemAmount <= 0 || redeemAmount > availableCoins ||
          redeemAmount % 10 != 0) {
        _showPopup(context,
            "Invalid number of coins.Do not exceed the available coins.");
        return;
      }
      // Show a loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator());
        },
      );

      try {
        await _spendCoin.spendToken(redeemAmount);
        Navigator.of(context).pop(); // Close the loading indicator
        _showPopup(context, 'Coins redeemed successfully!');
        _fetchAvailableCoins(); // Update available coins
      } catch (e) {
        Navigator.of(context).pop(); // Close the loading indicator
        _showPopup(context, 'Failed to redeem coins: $e');
      }

    }

    void _showPopup(BuildContext context, String message) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            content: Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.8,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * 0.3,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Popup Message', style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 20)),
                  SizedBox(height: 10),
                  Text(message, textAlign: TextAlign.center),
                ],
              ),
            ),
          );
        },
      );

      Future.delayed(const Duration(seconds: 5), () {
        Navigator.of(context).pop();
      });
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Redeem Coins'),
        ),
        body: Center(
          child: Card(
            margin: EdgeInsets.all(16.0),
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Available Coins: $availableCoins',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter coins to redeem',
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _redeemCoins,
                    child: Text('Redeem'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
}