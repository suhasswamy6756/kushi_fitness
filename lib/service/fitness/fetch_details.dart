import 'package:flutter_health_connect/flutter_health_connect.dart';

class FitnessDetails {
  List<HealthConnectDataType> types = [HealthConnectDataType.Steps];

  Future<int> fetchTotalSteps() async {
    var startTime = DateTime.now().subtract(const Duration(days: 4));
    var endTime = DateTime.now();
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
    return totalSteps;
  }


}
