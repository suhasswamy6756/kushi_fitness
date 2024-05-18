import 'package:flutter/material.dart';


class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> {
  int _currentStep = 0;
  bool _isHealthConnectInstalled = false;
  bool _isApiSupported = false;
  bool _isPermissionGranted = false;

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
            if (_currentStep < 3) {
              _currentStep += 1;
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
            title: const Text('Check API Support'),
            content: Text(_isApiSupported
                ? 'API supported'
                : 'API not supported. Please check compatibility'),
            isActive: _currentStep >= 1,
            state: _isApiSupported
                ? StepState.complete
                : StepState.indexed,
          ),
          Step(
            title: const Text('Grant Permission'),
            content: Text(_isPermissionGranted
                ? 'Permission granted'
                : 'Permission not granted. Grant access to proceed'),
            isActive: _currentStep >= 2,
            state: _isPermissionGranted
                ? StepState.complete
                : StepState.indexed,
          ),
        ],
      )
          : Center(
        child: ElevatedButton(
          onPressed: () {
            // Add logic here to handle the button press
            // For example, you can trigger Health Connect installation
            // or navigate to the installation page
          },
          child: const Text('Install Health Connect'),
        ),
      ),
    );
  }
}
