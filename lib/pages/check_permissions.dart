import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:url_launcher/url_launcher.dart';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  bool _isHealthConnectInstalled = false;

  @override
  void initState() {
    super.initState();
    _checkIfAppIsInstalled();
  }

  Future<void> _checkIfAppIsInstalled() async {
    try {
      bool result = await HealthConnectFactory.isAvailable();
      if (mounted) {
        setState(() {
          _isHealthConnectInstalled = result;
        });
      }
    } catch (e) {
      print("Error checking HealthConnect availability: $e");
      if (mounted) {
        setState(() {
          _isHealthConnectInstalled = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Connect Stepper'),
      ),
      body: _isHealthConnectInstalled
          ? Stepper(
        currentStep: _currentStep,
        onStepContinue: () {
          setState(() {
            if (_currentStep < 1) {
              _currentStep += 1;
            } else {

              Navigator.pushNamed(context, "/test_page");
            }
          });
        },
        onStepCancel: () {
          setState(() {
            if (_currentStep > 0) {
              _currentStep -= 1;
            }
          });
        },
        steps: <Step>[
          Step(
            title: const Text('Install Health Connect'),
            content: Text(_isHealthConnectInstalled
                ? 'Health Connect installed successfully'
                : 'Install Health Connect'),
            isActive: _currentStep >= 0,
            state: _isHealthConnectInstalled
                ? StepState.complete
                : StepState.indexed,
          ),
          Step(
            title: const Text('Grant Permission'),
            isActive: _currentStep >= 1,
            state: _currentStep >= 1 ? StepState.complete : StepState.indexed,
            content: GestureDetector(
              onTap: () {
                if (_currentStep == 1) {
                  _requestHealthConnectPermission();
                }
              },
              child: const Text('Grant access to proceed'),
            ),
          ),
        ],
      )
          : Center(
        child: ElevatedButton(
          onPressed: () async {
            await installHealthConnect();
          },
          child: const Text('Install Health Connect'),
        ),
      ),
    );
  }

  Future<void> installHealthConnect() async {
    var result = await HealthConnectFactory.isAvailable();
    if (!result) {
      launchUrl(
        Uri.parse("market://details?id=com.google.android.apps.healthdata"),
        mode: LaunchMode.externalApplication,
      );
    }
  }

  Future<void> _requestHealthConnectPermission() async {
    try {
      await HealthConnectFactory.requestPermissions([HealthConnectDataType.Steps]);
    } catch (e) {
      print("Error requesting Health Connect permission: $e");
    }
  }
}


