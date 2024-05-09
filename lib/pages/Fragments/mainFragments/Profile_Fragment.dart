import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kushi_3/pages/introslider.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:kushi_3/components/settingButtons.dart';
import 'package:kushi_3/service/auth/auth_service.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';


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
          .get(const GetOptions(source: Source.cache));

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
              const Padding(
                padding: EdgeInsets.only(right: 240.0),
                child: Text("Profile", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
              ),
              const SizedBox(height: 25, ),
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
                            decoration: const BoxDecoration(
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
                                    :const LineIcon(LineIcons.peace,color: Colors.black,size: 80,),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 75,),
                      const VerticalDivider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 50.0, left: 10.0),
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
              const SizedBox(height: 5,),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left:20.0),
                    child: Text(globals.userName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 50),),
                  )
              ),
              const SizedBox(height: 10,),
              settingButton(
                  text: "Rewards",
                  onTap: () => () {}
              ),
              const SizedBox(height: 30,),
              const Padding(
                padding: EdgeInsets.only(right:250.0, left: 10.0),
                child: Text('Settings', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
              ),
              const SizedBox(height: 10,),
              settingButton(
                  text: "Your Account",
                  onTap: () => () {}
              ),
              const SizedBox(height: 10,),
              settingButton(
                  text: "Notifications",
                  onTap: () => () {}
              ),
              const SizedBox(height: 10,),
              settingButton(
                  text: "Languages",
                  onTap: () => () {}
              ),
              const SizedBox(height: 30,),
              const SizedBox(height: 30,),
              const Padding(
                padding: EdgeInsets.only(right:125.0, left: 10.0),
                child: Text('Help and Support', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),),
              ),
              const SizedBox(height: 10,),
              settingButton(
                  text: "How everything works",
                  onTap: () => () {}
              ),
              const SizedBox(height: 10,),
              settingButton(
                  text: "FAQ",
                  onTap: () => () {}
              ),
              const SizedBox(height: 10,),
              settingButton(
                  text: "Contact Us",
                  onTap: () => () {}
              ),
              const SizedBox(height: 30,),



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
                      side: const BorderSide(
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
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  "Pro",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16, // Adjust as needed
                                  ),
                                ),
                              ),
                            ),


                            const Text(
                              "Upgrade to premium",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                              ),
                            ),
                            const Text(
                              "This subscription is auto-renewable",
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(

                            padding: const EdgeInsets.only(bottom: 5),

                            minimumSize: const Size(48, 48),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text(
                            ">",
                            style: TextStyle(fontSize: 32, color: Colors.white, fontWeight: FontWeight.w300),
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
                  final authService = AuthService();
                  authService.signOut();
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const IntroSlider()));
                  },
              ),
              const SizedBox(height: 25,),

            ]
        ),
      ),
    );
  }
}
