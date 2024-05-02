import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kushi_3/components/settingButtonAlt.dart';
import 'package:kushi_3/pages/notifications.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:kushi_3/components/settingButtonAlt.dart';
import 'package:kushi_3/service/auth/auth_service.dart';
import 'package:provider/provider.dart';


class settingsFragment extends StatefulWidget {

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
          SizedBox(height:60),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:150.0),
                child: Text("Settings", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),),
              ),
            ],
          ),
          SizedBox(height: 30,),
          Row(
            children: [
              settingButtonAlt(text: "Units of Measurement", onTap: (){})
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              settingButtonAlt(text: "Notifications", onTap: (){})
            ],
          ),
          SizedBox(height: 10,),
          Row(
            children: [
              settingButtonAlt(text: "Language", onTap: (){})
            ],
          ),
          SizedBox(height: 10,),
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
