import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:url_launcher/url_launcher.dart';



class HealthConnectStepper extends StatefulWidget {
  const HealthConnectStepper({super.key});

  @override
  State<HealthConnectStepper> createState() => _HealthConnectStepperState();
}

class _HealthConnectStepperState extends State<HealthConnectStepper> {
  int _currentStep = 0;
  String resultText = '';


  List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    HealthConnectDataType.HeartRate,
    HealthConnectDataType.SleepSession,
    HealthConnectDataType.OxygenSaturation,
    HealthConnectDataType.RespiratoryRate,
  ];

  void _nextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep += 1;
      }
    });
  }

  void _previousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep -= 1;
      }
    });
  }

  void _completeSetup() {
    setState(() {
      resultText = 'Setup Complete';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Health Connect Setup'),
        ),
        body: Stepper(
          currentStep: _currentStep,
          onStepContinue: _nextStep,
          onStepCancel: _previousStep,
          steps: [
            Step(
              title: const Text('Check Health Connect Support'),
              content: CheckHealthConnectSupportStep(onNext: _nextStep),
              isActive: _currentStep >= 0,
            ),
            Step(
              title: const Text('Check Health Connect Installation'),
              content: CheckHealthConnectInstallationStep(onNext: _nextStep),
              isActive: _currentStep >= 1,
            ),
            Step(
              title: const Text('Request Permissions'),
              content: RequestPermissionsStep(onNext: _completeSetup),
              isActive: _currentStep >= 2,
            ),
          ],
        ),
      ),
    );
  }
}

class CheckHealthConnectSupportStep extends StatelessWidget {
  final VoidCallback onNext;

  CheckHealthConnectSupportStep({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Ensure Health Connect API is supported.'),
        ElevatedButton(
          onPressed: () async {
            try {
              var result = await HealthConnectFactory.isApiSupported();
              if (result) {
                onNext();
              } else {
                // Handle unsupported API case
                print('Health Connect API is not supported.');
              }
            } catch (e) {
              print('Error checking API support: $e');
            }
          },
          child: const Text('Check Health Connect Support'),
        ),
      ],
    );
  }
}

class CheckHealthConnectInstallationStep extends StatelessWidget {
  final VoidCallback onNext;

  CheckHealthConnectInstallationStep({required this.onNext});
  static installHealthConnect() async {
    // return HealthConnectFactory.installHealthConnect();
    var result = await HealthConnectFactory.isAvailable();
    if (!result) {
      launchUrl(
        Uri.parse("market://details?id=com.google.android.apps.healthdata"),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Ensure Health Connect is installed.'),
        ElevatedButton(
          onPressed: () async {
            try {
              var result = await HealthConnectFactory.isApiSupported();
              if (result) {
                onNext();
              } else {
                // await HealthConnectFactory.installHealthConnect();
                installHealthConnect();
                onNext();
              }
            } catch (e) {
              print('Error checking or installing Health Connect: $e');
            }
          },
          child: const Text('Check Health Connect Installation'),
        ),
      ],
    );
  }
}

class RequestPermissionsStep extends StatelessWidget {
  final VoidCallback onNext;
  final List<HealthConnectDataType> types = [
    HealthConnectDataType.Steps,
    HealthConnectDataType.HeartRate,
    HealthConnectDataType.SleepSession,
    HealthConnectDataType.OxygenSaturation,
    HealthConnectDataType.RespiratoryRate,
  ];
  final bool readOnly = false;

  RequestPermissionsStep({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Request necessary permissions for Health Connect.'),
        ElevatedButton(
          onPressed: () async {
            try {
              var result = await HealthConnectFactory.requestPermissions(
                types,
                readOnly: readOnly,
              );
              if (result) {
                onNext();
              } else {
                // Handle permission denied case
                print('Permissions denied.');
              }
            } catch (e) {
              print('Error requesting permissions: $e');
            }
          },
          child: const Text('Request Permissions'),
        ),
      ],
    );
  }
}
