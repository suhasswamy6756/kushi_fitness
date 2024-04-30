import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'bar_data.dart';

class MyBarGraph extends StatelessWidget {
  final List weeklySummary;

  MyBarGraph({
    super.key,
    required this.weeklySummary,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      sunAmount: weeklySummary[0],
      monAmount: weeklySummary[1],
      tueAmount: weeklySummary[2],
      wedAmount: weeklySummary[3],
      thuAmount: weeklySummary[4],
      friAmount: weeklySummary[5],
      satAmount: weeklySummary[6],
    );
    myBarData.initializeBarData();

    return BarChart(BarChartData(
        minY: 0,
        maxY: 100,
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true,getTitlesWidget: getBottomTitles)),

        ),
        barGroups: myBarData.barData
            .map(
              (data) => BarChartGroupData(
                x: data.x,
                barRods: [
                  BarChartRodData(
                    toY: data.y,
                    color: Colors.green,
                    width: 10,
                    borderRadius: BorderRadius.circular(4),
                    backDrawRodData: BackgroundBarChartRodData(
                      show: true,
                      toY: 100,
                      color: Theme.of(context).colorScheme.background,
                    )
                  ),
                ],
              ),
            )
            .toList()));
  }
}
Widget getBottomTitles(double value,TitleMeta meta){
  const style = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
    Widget text=Text("suhas");
  switch(value.toInt()){
    case 0:
      text= const Text('S',style: style);
      break;
    case 1:
      text= const Text('M',style: style);
      break;
    case 2:
      text= const Text('T',style: style);
      break;
    case 3:
      text= const Text('W',style: style);
      break;
    case 4:
      text= const Text('T',style: style);
      break;
    case 5:
      text= const Text('F',style: style);
      break;
    case 6:
      text= const Text('S',style: style);
      break;

  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide );
}
