import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kushi_3/components/mybutton.dart';
import 'package:kushi_3/model/user_data.dart';
import 'package:kushi_3/pages/mainactivity.dart';
import 'package:kushi_3/service/firestore_service.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SelectWeight extends StatefulWidget {
  const SelectWeight({super.key});

  @override
  State<StatefulWidget> createState() => selectWeightState();
}

var labelStart = 1;

class selectWeightState extends State<SelectWeight> {
 final FirestoreService _firestoreService= FirestoreService();

  var btnStyle1 = const TextStyle(color: Colors.black);
  var btnStyle2 = const TextStyle(
    color: Colors.black,
  );
  var labels = ['kg', 'lb'];
  var weightUnit = "lb";
  TextEditingController weight = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 60,
              ),
              const Text("Step 4 of 8"),
              const SizedBox(
                height: 90,
              ),
              const Text(
                "Enter weidjfxc",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 29,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ToggleSwitch(
                  minWidth: 150.0,
                  initialLabelIndex: labelStart,
                  cornerRadius: 30.0,
                  radiusStyle: true,
                  activeBgColor: [Colors.white],
                  customTextStyles: [btnStyle1, btnStyle2],
                  borderColor: const [Colors.grey],
                  inactiveBgColor: Colors.white54,
                  inactiveFgColor: Colors.grey,
                  totalSwitches: 2,
                  labels: ["Kilograms", "Pounds"],
                  onToggle: (index) {
                    if (index != null) {
                      setState(() {
                        labelStart = index;
                        weightUnit = labels[index];
                        print(weightUnit);
                      });
                    }
                  }),
              const SizedBox(
                height: 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      padding: EdgeInsets.all(2.5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        // Adjust the radius as per your requirement
                        border: Border.all(color: Colors.grey),
                      ),
                      width: 100,
                      child: TextField(
                        controller: weight,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none)),

                  ),
                  const SizedBox(width: 10),

                  Text(weightUnit)
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              MyButton(
                text: "Continue",
                onTap: () {
                  userDataMap["weight"]="${weight.text} $weightUnit";


                  _firestoreService.updateUserDocument(_firestoreService.getCurrentUserId()!, userDataMap, context);

                  Navigator.pushNamedAndRemoveUntil(
                      context, '/userinfo', (route) => false);
                },
              ),
            ],
          ),
        ));
  }
  @override
  void dispose() {
    // TODO: implement dispose
    userDataMap.clear();
    super.dispose();
  }
}
