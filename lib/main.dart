import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kushi_3/pages/Fragments/mainFragments/group_fragment.dart';
// import 'package:kushi/pages/Fragments/mainFragments/group_fragment.dart';
// import 'package:kushi/pages/otp.dart';
// import 'package:kushi/pages/selectGender.dart';
// import 'package:kushi/pages/selectHeight.dart';
// import 'package:kushi/pages/selectWeight.dart';
// import 'package:kushi/pages/signin.dart';
// import 'package:kushi/pages/signup.dart';
// import 'package:kushi/pages/testingPages/stepTest.dart';
// import 'package:kushi/service/auth/auth_gate.dart';
// import 'package:kushi/themes/dark_mode.dart';
// import 'package:kushi/themes/light_mode.dart';

// import 'package:kushi_3/pages/contact_list.dart';
import 'package:kushi_3/pages/introslider.dart';
import 'package:kushi_3/pages/mainactivity.dart';
import 'package:kushi_3/pages/otp.dart';
// import 'package:kushi_3/pages/person_list.dart';
import 'package:kushi_3/pages/selectGender.dart';
import 'package:kushi_3/pages/selectHeight.dart';
import 'package:kushi_3/pages/selectWeight.dart';
import 'package:kushi_3/pages/signup.dart';
import 'package:kushi_3/pages/testingPages/database.dart';
import 'package:kushi_3/service/auth/auth_gate.dart';
import 'package:kushi_3/service/auth/auth_service.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:kushi_3/pages/signin.dart';
import 'package:kushi_3/themes/dark_mode.dart';
import 'package:kushi_3/themes/light_mode.dart';
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:kushi_3/pages/testingPages/stepTest.dart';
import 'package:kushi_3/pages/testingPages/fireStoreTest.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures all plugins are initialized
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );// Asynchronously initialize Firebase
  await FirebaseAppCheck.instance.activate();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthService()), // Provide AuthService
            ChangeNotifierProvider(create: (_) => ContactProvider()), // Provide ContactProvider
          ],
    // ChangeNotifierProvider(create: (context) => ContactProvider(),
      child: const MyApp(),

    )
  ); // Run your application
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: "flutter demo",
        theme: lightMode,
        darkTheme: darkMode,
        routes: {
          '/OTPPage': (context) => OTPVerificationPage(),
          '/selectGender': (context) => const SelectGender(),
          '/selectHeight': (context) => const SelectHeight(),
          '/selectWeight' : (context) => const SelectWeight(),
          '/test_page': (context) => const stepTest(),
          '/phoneVerification': (context) => SignIn(),
          '/userinfo': (context) => SignUp(),
          '/contactList':(context) => ContactList(),
        },

      home:  MainActivity(namey: "suhas",),
    );
  }
}
