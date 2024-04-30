import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:kushi_3/pages/introslider.dart';
import 'package:kushi_3/pages/notifications.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:kushi_3/components/settingButtons.dart';
import 'package:kushi_3/service/auth/auth_service.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';


class ProfileFragment extends StatefulWidget {
  String namey;
  ProfileFragment({required this.namey, super.key});

  @override
  State<ProfileFragment> createState() => _profilePageState();
}

class _profilePageState extends State<ProfileFragment> {
  late String name;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    name = widget.namey;
    getProfileImageUrl(); // Fetch profile image URL when widget initializes
  }

  Future<void> getProfileImageUrl() async {
    try {
      // Fetch user document from Firestore
      DocumentSnapshot<Map<String, dynamic>> userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(GetOptions(source: Source.cache));

      // Retrieve profile image URL from the user document
      setState(() {
       profileImageUrl = userSnapshot.data()?['profileUrl'];
      });
    } catch (e) {
      print('Error fetching profile image URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              SizedBox(height: 60, ),
              Padding(
                padding: const EdgeInsets.only(right: 240.0),
                child: Text("Profile", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              ),
              SizedBox(height: 25, ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Stack(

                        children: <Widget>[
                          Container(
                            width: 140, // Adjust according to your needs
                            height: 140, // Adjust according to your needs
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                  colors: [Colors.redAccent, Colors.lightBlueAccent], // Example gradient colors
                                  begin: Alignment.topRight, // Example gradient begin alignment
                                  end: Alignment.bottomLeft,
                                  stops: [0.2, 0.8]// Example gradient end alignment
                              ), // Change color according to your needs
                            ),
                          ),
                          // Square profile image
                          Positioned(
                            left: 10,
                            top: 10,
                            child: Container(
                              width: 120, // Adjust according to your needs
                              height: 120, // Adjust according to your needs
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 15.0), // Circular border
                              ),
                              child: ClipOval(
                                child: profileImageUrl != null
                                    ? Image.network(
                                  profileImageUrl!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                                    :LineIcon(LineIcons.peace,color: Colors.black,size: 80,),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 75,),
                      VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 50.0, left: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Joined"),
                              Text("2 months ago", style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 5,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Text(globals.userName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
                  )
              ),
              const SizedBox(height: 10,),
              settingButton(
                  text: "Edit profile",
                  onTap: () => () {}
              ),
              const SizedBox(height: 10,),
              settingButton(
                  text: "Privacy profile",
                  onTap: () => () {}
              ),
              const SizedBox(height: 10,),
              settingButton(
                  text: "Settings",
                  onTap: () => () {}
              ),
              const SizedBox(height: 20,),
              Container(
                width: double.infinity,
                height: 120,
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: OutlinedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      foregroundColor: Colors.white,
                      elevation: 10,
                      side: BorderSide(
                          color: Colors.black12,
                          width: 1.5
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:16.0, right: 140),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  "Pro",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16, // Adjust as needed
                                  ),
                                ),
                              ),
                            ),


                            Text(
                              "Upgrade to premium",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              "This subscription is auto-renewable",
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            ">",
                            style: TextStyle(fontSize: 32, color: Colors.white),
                          ),
                          style: TextButton.styleFrom(

                            padding: EdgeInsets.only(bottom: 5),

                            minimumSize: Size(48, 48),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        ),
                      ],
                    )
                ),
              ),
              const SizedBox(height: 10,),
              settingButton(
                text: "Sign out",
                onTap: (){
                  final _authService = AuthService();
                  _authService.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> IntroSlider()));
                  },
              ),

            ]
        ),
      ),
    );
  }
}
