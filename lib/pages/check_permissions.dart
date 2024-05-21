import 'package:flutter/material.dart';
import 'package:flutter_health_connect/flutter_health_connect.dart';
import 'package:kushi_3/components/message.dart';
import 'package:url_launcher/url_launcher.dart';

class StepperDemo extends StatefulWidget {
  @override
  _StepperDemoState createState() => _StepperDemoState();
}

class _StepperDemoState extends State<StepperDemo> with WidgetsBindingObserver {
  int _currentStep = 0;
  bool _isHealthConnectInstalled = false;
  bool _isApiSupported = false;
  bool _isPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    HealthConnectFactory.installHealthConnect();
    WidgetsBinding.instance.addObserver(this);
    _checkIfAppIsInstalled();
    // _permissionsHealthConnect();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      installHealthConnect();
      _checkIfAppIsInstalled();
      _permissionsHealthConnect();
    }
  }

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


  Future<void> _checkIfAppIsInstalled() async {
    try {
      bool result = await HealthConnectFactory.isAvailable();
      if (mounted) {
        setState(() {
          _isHealthConnectInstalled = result;
        });
      }
    } catch (e) {
      // Handle the error appropriately
      print("Error checking HealthConnect availability: $e");
      if (mounted) {
        setState(() {
          _isHealthConnectInstalled = false;
        });
      }
    }
  }

  Future<void> _permissionsHealthConnect() async {
    try {
      bool result = await HealthConnectFactory.hasPermissions(
          [HealthConnectDataType.Steps]);
      if (mounted) {
        setState(() {
          _isPermissionGranted = result;
        });
        if (!result) {
          await HealthConnectFactory.openHealthConnectSettings();
        }
      }
    } catch (e) {
      showMessage(context, e.toString());
      if (mounted) {
        setState(() {
          _isPermissionGranted = false;
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
          setState(() async {
            if (_currentStep < 1) {
              _currentStep += 1;
              if (_currentStep == 1) {
                _permissionsHealthConnect();
              }
            }
            else {
              if (_isPermissionGranted) {
                Navigator.pushNamed(context, '/test_page');
              }
              else {
                await HealthConnectFactory.openHealthConnectSettings();
              }
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
            title: Text(_isPermissionGranted ? 'Continue' : 'Grant Permission'),
            content: PermissionStepContent(
              isPermissionGranted: _isPermissionGranted,
              grantPermission: _permissionsHealthConnect,
            ),
            isActive: _currentStep >= 1,
            state: _isPermissionGranted
                ? StepState.complete
                : StepState.indexed,
          ),
        ],
      )
          : Center(
        child: ElevatedButton(
          onPressed: () async {
            await HealthConnectFactory.installHealthConnect();
          },
          child: const Text('Install Health Connect'),
        ),
      ),
    );
  }
}

class PermissionStepContent extends StatelessWidget {
  final bool isPermissionGranted;
  final Future<void> Function() grantPermission;

  const PermissionStepContent({
    Key? key,
    required this.isPermissionGranted,
    required this.grantPermission,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(isPermissionGranted
            ? 'Permission granted'
            : 'Permission not granted. Grant access to proceed'),
        SizedBox(height: 16.0),
        // if (!isPermissionGranted)
        //   ElevatedButton(
        //     onPressed: () async {
        //       await grantPermission();
        //     },
        //     child: Text('Grant Permission'),
        //   ),
      ],
    );
  }
}
