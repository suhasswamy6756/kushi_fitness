import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';

import 'package:intl/intl.dart';
import 'package:kushi_3/pages/mainactivity.dart';
import 'package:kushi_3/service/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:kushi_3/service/firestore_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as developer;
import 'package:kushi_3/model/globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import '../../service/auth/auth_gate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class stepTest extends StatefulWidget {
  const stepTest({super.key});

  @override
  State<stepTest> createState() => _stepTestState();
}

class _stepTestState extends State<stepTest> {
  FirestoreService _firestoreService = FirestoreService();
  // List<HealthConnectDataType> types = [
  //   HealthConnectDataType.ActiveCaloriesBurned,
  //   HealthConnectDataType.BasalBodyTemperature,
  //   HealthConnectDataType.BasalMetabolicRate,
  //   HealthConnectDataType.BloodGlucose,
  //   HealthConnectDataType.BloodPressure,
  //   HealthConnectDataType.BodyFat,
  //   HealthConnectDataType.BodyTemperature,
  //   HealthConnectDataType.BoneMass,
  //   HealthConnectDataType.CervicalMucus,
  //   HealthConnectDataType.CyclingPedalingCadence,
  //   HealthConnectDataType.Distance,
  //   HealthConnectDataType.ElevationGained,
  //   HealthConnectDataType.ExerciseEvent,
  //   HealthConnectDataType.ExerciseLap,
  //   HealthConnectDataType.ExerciseRepetitions,
  //   HealthConnectDataType.ExerciseSession,
  //   HealthConnectDataType.FloorsClimbed,
  //   HealthConnectDataType.HeartRate,
  //   HealthConnectDataType.Height,
  //   HealthConnectDataType.HipCircumference,
  //   HealthConnectDataType.Hydration,
  //   HealthConnectDataType.LeanBodyMass,
  //   HealthConnectDataType.MenstruationFlow,
  //   HealthConnectDataType.Nutrition,
  //   HealthConnectDataType.OvulationTest,
  //   HealthConnectDataType.OxygenSaturation,
  //   HealthConnectDataType.Power,
  //   HealthConnectDataType.RespiratoryRate,
  //   HealthConnectDataType.RestingHeartRate,
  //   HealthConnectDataType.SexualActivity,
  //   HealthConnectDataType.SleepSession,
  //   HealthConnectDataType.SleepStage,
  //   HealthConnectDataType.Speed,
  //   HealthConnectDataType.StepsCadence,
  //   HealthConnectDataType.Steps,
  //   HealthConnectDataType.SwimmingStrokes,
  //   HealthConnectDataType.TotalCaloriesBurned,
  //   HealthConnectDataType.Vo2Max,
  //   HealthConnectDataType.WaistCircumference,
  //   HealthConnectDataType.Weight,
  //   HealthConnectDataType.WheelchairPushes,
  // ];

  List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    // HealthConnectDataType.SleepStage

  ];

  bool readOnly = false;
  String resultText = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(
          title: const Text('Health Connect'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton(
              onPressed: () async {
                var result;
                try{
                  result = await HealthConnectFactory.isApiSupported();
                }catch(e){
                  result = false;
                }
                resultText = 'isApiSupported: $result';


                _updateResultText();
              },
              child: const Text('isApiSupported'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result;
                try{
                  result = await HealthConnectFactory.isAvailable();
                }catch(e){
                  result = false;
                }
                resultText = 'isAvailable: $result';


                _updateResultText();
              },
              child: const Text('Check installed'),
            ),
            ElevatedButton(
              onPressed: () async {
                // await HealthConnectFactory.installHealthConnect();
                launchUrl(
                  Uri.parse("market://details?id=com.google.android.apps.healthdata"),
                  mode: LaunchMode.externalApplication,
                );
              },
              child: const Text('Install Health Connect'),
            ),
            ElevatedButton(
              onPressed: () async {

                try{
                  await HealthConnectFactory.installHealthConnect();

                }catch(e){
                  resultText ="not installed";
                }
                _updateResultText();
                // launchUrl(
                //   Uri.parse("market://details?id=com.google.android.apps.healthdata"),
                //   mode: LaunchMode.externalApplication,
                // );
              },
              child: const Text('Install Health Connect'),
            ),
            ElevatedButton(
              onPressed: () async {
                try{
                  await HealthConnectFactory.openHealthConnectSettings();

                }catch(e){
                  print("error");
                }

              },
              child: const Text('Open Health Connect Settings'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result;
                try{
                  result = await HealthConnectFactory.hasPermissions(
                    types,
                    readOnly: readOnly,
                  );
                }catch(e){
                  result = false;
                }

                resultText = 'hasPermissions: $result';
                _updateResultText();
              },
              child: const Text('Has Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result;
                try{
                  result = await HealthConnectFactory.requestPermissions(
                    types,
                    readOnly: readOnly,
                  );
                }catch(e){
                  result = false;
                }

                resultText = 'requestPermissions: $result';
                _updateResultText();
              },
              child: const Text('Request Permissions'),
            ),ElevatedButton(
              onPressed: () async {
                var result = "${globals.stepsToday}"+"counted steps:${globals.countedSteps}";
                resultText = 'requestPermissions: $result';
                _updateResultText();
              },
              child: const Text('get something'),
            ),
            ElevatedButton(
              onPressed: () async {
                var startTime = DateTime.now().subtract(Duration(
                  hours: DateTime
                      .now()
                      .hour,
                  minutes: DateTime
                      .now()
                      .minute,
                  seconds: DateTime
                      .now()
                      .second,
                  milliseconds: DateTime
                      .now()
                      .millisecond,
                  microseconds: DateTime
                      .now()
                      .microsecond,
                ));
                var endTime = DateTime.now();
                try {
                  final requests = <Future>[];
                  Map<String, dynamic> typePoints = {};
                  for (var type in types) {
                    requests.add(HealthConnectFactory.getRecord(
                      type: type,
                      startTime: startTime,
                      endTime: endTime,
                    ).then((value) => typePoints.addAll({type.name: value})));
                  }
                  await Future.wait(requests);
                  var stepList = typePoints['Steps']['records'];
                  var totalSteps = 0;
                  for (var step in stepList) {
                    totalSteps += step['count'] as int;
                  }
                  globals.stepsToday = totalSteps;
                  resultText = '$totalSteps';
                } catch (e) {
                  resultText = e.toString();
                  print(resultText);
                }
                _updateResultText();
              },
              child: const Text('Get Steps'),
            ),
            ElevatedButton(
              onPressed: () async {
                developer.log(globals.stepsToday.toString());
                var stepsNow = globals.stepsToday;
                var curDate = DateFormat('MMddyyyy').format(DateTime.now());
                if (stepsNow >= 10000 && curDate != globals.date) {
                  if (globals.dailyToken == false) {
                    globals.date = curDate;
                    globals.generate40RupeeToken(_firestoreService.getCurrentUserId()!);
                    globals.countedSteps -= 10000;
                  }
                  while (globals.countedSteps > 5000) {
                    developer.log(globals.countedSteps.toString());
                    globals.generate20RupeeToken(_firestoreService.getCurrentUserId()!);
                    globals.countedSteps -= 5000;
                  }
                }
                int fortytokens = await globals.get40CoinNumber(_firestoreService.getCurrentUserId());
                int twentyTokens = await globals.get20CoinNumber(_firestoreService.getCurrentUserId());
                resultText =
                '40 Rupee Tokens: $fortytokens and 20 rupee tokens: $twentyTokens';
                _updateResultText();
              },
              child: const Text('Get Coins'),
            ),
            ElevatedButton(
              onPressed: () async {
                var startTime = DateTime.now().subtract(Duration(
                  hours: DateTime
                      .now()
                      .hour,
                  minutes: DateTime
                      .now()
                      .minute,
                  seconds: DateTime
                      .now()
                      .second,
                  milliseconds: DateTime
                      .now()
                      .millisecond,
                  microseconds: DateTime
                      .now()
                      .microsecond,
                ));
                var endTime = DateTime.now();
                try {
                  final requests = <Future>[];
                  Map<String, dynamic> typePoints = {};
                  for (var type in types) {
                    requests.add(HealthConnectFactory.getRecord(
                      type: type,
                      startTime: startTime,
                      endTime: endTime,
                    ).then((value) => typePoints.addAll({type.name: value})));
                  }
                  await Future.wait(requests);
                  typePoints = typePoints['TotalCaloriesBurned'];
                  var totalEnergy = 0.0;
                  var counter = 0;
                  for (var record in typePoints.values) {
                    if (counter == 1) {
                      break;
                    }
                    for (var energy in record) {
                      totalEnergy += energy['energy']['kilocalories'].toInt();
                    }
                    developer.log(totalEnergy.toString());
                    counter++;
                  }
                  resultText = '$totalEnergy';
                } catch (e) {
                  resultText = e.toString();
                  print(resultText);
                }
                _updateResultText();
              },
              child: const Text('Get Calories'),
            ),
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AuthGate()),
              );
            },
                child: const Text('Move to Main')),
            SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () async {

                var startTime =
                DateTime.now().subtract(const Duration(days: 4));
                var endTime = DateTime.now();
                var results = await HealthConnectFactory.getRecord(
                type: HealthConnectDataType.Steps,
                startTime: startTime,
                endTime: endTime,
                );
                // results.forEach((key, value) {
                //   if (key == HealthConnectDataType.Steps.name) {
                //     print(value);
                //   }
                // });
                resultText = '\ntype: $types\n\n$results';
                _updateResultText();
              },
              child: const Text('Get Record'),
            ),
            Text(resultText),
          ],
        ),
      ),
    );
  }

  void _updateResultText() {
    setState(() {});
  }
}