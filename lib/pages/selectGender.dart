
import 'package:flutter/material.dart';
import 'package:kushi_3/components/mybutton.dart';
import 'package:kushi_3/components/optionButton.dart';
import 'package:kushi_3/components/show_alert_box.dart';
import 'package:kushi_3/model/user_data.dart';
import 'package:kushi_3/service/firestore_service.dart';


class SelectGender extends StatefulWidget {
  const SelectGender({super.key});

  @override
  State<StatefulWidget> createState() => selectGenderState();
}


// ignore: camel_case_types
class selectGenderState extends State<SelectGender> {

  int selectedOptionIndex = -1;
  String gender = "";
  final FirestoreService _firestoreService = FirestoreService();
  // -1 shows that no option is initially selected

  void selectOption(int index){
    setState(() {
      selectedOptionIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 60,),
              const Text("Step 1 of 8", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(height: 90,),
              const Text("Choose gender", style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 29,
              ),),
              const SizedBox(height: 30,),
              OptionButton(
                emojiText: "👩",
                text: "Female",
                isSelected: selectedOptionIndex == 0,
                onTap: () {
                  selectOption(0);
                  userDataMap["gender"]="female";
                }
              ),
              const SizedBox(height: 30,),
              OptionButton(
                  emojiText: "👨",
                  text: "Male",
                  isSelected: selectedOptionIndex == 1,
                  onTap: () {
                    selectOption(1);
                    userDataMap["gender"]="male";

                  }
              ),
              const SizedBox(height: 30,),
              OptionButton(
                  emojiText: "🧓",
                  text: "Other",
                  isSelected: selectedOptionIndex == 2,
                  onTap: () {
                    selectOption(2);
                    userDataMap["gender"]="other";


                  }
              ),

              const SizedBox(height: 120,),
              MyButton(text: "Continue", onTap: () {

                userDataMap['userId'] = _firestoreService.getCurrentUserId()!;
                Navigator.pushNamed(context,'/selectHeight',arguments: userDataMap );

                // try{
                //   _firestoreService.updateUserDocument(_firestoreService.getCurrentUserId()!, userDataMap, context).then((value)=>Navigator.pushNamed(context,'/selectHeight',arguments: userDataMap ));
                //
                // }catch(e){
                //   ShowAlertBox(text:e.toString());
                // }



              },
             ),
            ],
          ),
        )
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    // userDataMap.clear();
    super.dispose();
  }
}