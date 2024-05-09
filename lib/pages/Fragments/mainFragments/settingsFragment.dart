import 'package:flutter/material.dart';
import 'package:kushi_3/components/settingButtonAlt.dart';


class settingsFragment extends StatefulWidget {
  const settingsFragment({super.key});


  @override
  State<settingsFragment> createState() => _settingsState();
}

class _settingsState extends State<settingsFragment> {
  @override
  void initState() {
    super.initState(); // Accessing namey from the widget instance
  }

  // Future<void> signOut() async {
  //   final _authService = Provider.of<AuthService>(context,listen:false);
  //   _authService.signOut();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height:60),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left:150.0),
                child: Text("Settings", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),),
              ),
            ],
          ),
          const SizedBox(height: 30,),
          Row(
            children: [
              settingButtonAlt(text: "Units of Measurement", onTap: (){})
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              settingButtonAlt(text: "Notifications", onTap: (){})
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              settingButtonAlt(text: "Language", onTap: (){})
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              settingButtonAlt(text: "Contact Us", onTap: (){})
            ],
          ),
        ],
      ),
    );
  }
}
