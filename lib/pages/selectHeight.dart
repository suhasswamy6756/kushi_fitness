import 'package:flutter/material.dart';
import 'package:kushi_3/model/user_data.dart';
import 'package:kushi_3/pages/selectWeight.dart';
import 'package:kushi_3/service/firestore_service.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:kushi_3/components/mybutton.dart';

class SelectHeight extends StatefulWidget {
  const SelectHeight({super.key});

  @override
  State<StatefulWidget> createState() => selectHeightState();
}

var labelStart = 1;
var btnStyle1 = const TextStyle(
  color: Colors.black,
);
var btnStyle2 = const TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
);

class selectHeightState extends State<SelectHeight> {
  var labels = ['ft', 'cm'];
  var heightUnit = "cm";
  TextEditingController height = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

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
              const Text("Step 5 of 8"),
              const SizedBox(
                height: 90,
              ),
              const Text(
                "Enter height",
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
                  customTextStyles: [btnStyle2, btnStyle1],
                  borderColor: const [Colors.grey],
                  inactiveBgColor: Colors.white54,
                  inactiveFgColor: Colors.grey,
                  totalSwitches: 2,
                  labels: ["Feet", "Centimetre"],
                  onToggle: (index) {
                    if (index != null) {
                      setState(() {
                        var temp = btnStyle1;
                        btnStyle1 = btnStyle2;
                        btnStyle2 = temp;
                        labelStart = index;
                        heightUnit = labels[index];
                        print(heightUnit);
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
                        controller: height,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: InputBorder.none))),
                  const SizedBox(width: 10),
                  Text(heightUnit)
                ],
              ),
              const SizedBox(
                height: 100,
              ),
              MyButton(
                text: "Continue",
                onTap: () {
                  userDataMap['height']="${height.text} $heightUnit";
                  _firestoreService.updateUserDocument(_firestoreService.getCurrentUserId()!, userDataMap, context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/selectWeight', (route) => false,arguments: userDataMap);
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
