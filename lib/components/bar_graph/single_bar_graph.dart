import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SingleHorizontalBarGraph extends StatelessWidget {
  final double value;
  final Color barColor;

  SingleHorizontalBarGraph(this.value, {this.barColor = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: value * 1.1,
        minY: 0,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles :SideTitles(showTitles: true,)),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,

          ),
        ],
      ),
    );
  }
}
