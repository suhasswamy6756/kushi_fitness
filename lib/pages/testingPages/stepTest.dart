import 'package:kushi_3/pages/mainactivity.dart';
import 'package:kushi_3/service/auth/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:developer' as developer;

import '../../service/auth/auth_gate.dart';


class stepTest extends StatefulWidget{
  const stepTest ({super.key});
  @override
  State<StatefulWidget> createState() => stepTestState();
}


class stepTestState extends State<stepTest> {

  List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    HealthConnectDataType.TotalCaloriesBurned
    // HealthConnectDataType.HeartRate,
    // HealthConnectDataType.SleepSession,
    // HealthConnectDataType.OxygenSaturation,
    // HealthConnectDataType.RespiratoryRate,
  ];

  bool readOnly = true;
  String resultText = '';

  String token = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Health Connect Permission Page'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.isApiSupported();
                resultText = 'isApiSupported: $result';
                _updateResultText();
              },
              child: const Text('isApiSupported'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.isAvailable();
                resultText = 'isAvailable: $result';
                _updateResultText();
              },
              child: const Text('Check installed'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await HealthConnectFactory.installHealthConnect();
                  resultText = 'Install activity started';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();
              },
              child: const Text('Install Health Connect'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await HealthConnectFactory.openHealthConnectSettings();
                  resultText = 'Settings activity started';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();

              },
              child: const Text('Open Health Connect Settings'),
            ),
            ElevatedButton(
              onPressed: () async {
                var result = await HealthConnectFactory.hasPermissions(
                  types,
                  readOnly: readOnly,
                );
                resultText = 'hasPermissions: $result';
                _updateResultText();
              },
              child: const Text('Has Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  var result = await HealthConnectFactory.requestPermissions(
                    types,
                    readOnly: readOnly,
                  );
                  resultText = 'requestPermissions: $result';
                } catch (e) {
                  resultText = e.toString();
                }
                _updateResultText();
              },
              child: const Text('Request Permissions'),
            ),
            ElevatedButton(
              onPressed: () async {
                var startTime = DateTime.now().subtract(Duration(
                  hours: DateTime.now().hour,
                  minutes: DateTime.now().minute,
                  seconds: DateTime.now().second,
                  milliseconds: DateTime.now().millisecond,
                  microseconds: DateTime.now().microsecond,
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
                  for(var step in stepList){
                    totalSteps+=step['count'] as int;
                  }
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
                var startTime = DateTime.now().subtract(Duration(
                  hours: DateTime.now().hour,
                  minutes: DateTime.now().minute,
                  seconds: DateTime.now().second,
                  milliseconds: DateTime.now().millisecond,
                  microseconds: DateTime.now().microsecond,
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
                  for (var record in typePoints.values){
                    if(counter == 1){
                      break;
                    }
                    for(var energy in record){
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
                MaterialPageRoute(builder: (context) => MainActivity(namey: "suhas")),
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