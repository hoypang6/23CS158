// ignore_for_file: must_be_immutable

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  var weekList; //Contains list of dates until start of the week
  var stringWL; //Contains list of dates until start of the week in STRING
  var stepList; //you know what this is right?
  Chart({required this.stepList, required this.stringWL, required this.weekList});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: const FlGridData(show: false),
        alignment: BarChartAlignment.spaceAround,
        maxY: 2000, //max y height
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: Colors.cyan.withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.blue[20],
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = stringWL[0].substring(0, 5); //day 1
        break;
      case 1:
        text = stringWL[1].substring(0, 5); //day 2
        break;
      case 2:
        text = stringWL[2].substring(0, 5); //day 3
        break;
      case 3:
        text = stringWL[3].substring(0, 5); //day 4
        break;
      case 4:
        text = stringWL[4].substring(0, 5); //day 5
        break;
      case 5:
        text = stringWL[5].substring(0, 5); //you get the idea
        break;
      case 6:
        text = stringWL[6].substring(0, 5);
        break;
      default:
        text = '';
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: const TextStyle(fontSize: 10)),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 40,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => const LinearGradient(
        colors: [
            Color(0xfff39060),
            Color(0xffffb56b),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: stepList[0].toDouble(),
              gradient: _barsGradient,
              width: 20,
              borderRadius:const BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: stepList[1].toDouble(),
              gradient: _barsGradient,
              width: 20,
              borderRadius:BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: stepList[2].toDouble(),
              gradient: _barsGradient,
              width: 20,
              borderRadius:BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: stepList[3].toDouble(),
              gradient: _barsGradient,
              width: 20,
              borderRadius:BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: stepList[4].toDouble(),
              gradient: _barsGradient,
              width: 20,
              borderRadius:BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: stepList[5].toDouble(),
              gradient: _barsGradient,
              width: 20,
              borderRadius:BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: stepList[6].toDouble(),
              gradient: _barsGradient,
              width: 20,
              borderRadius:BorderRadius.only(
                  topLeft: Radius.circular(2),
                  topRight: Radius.circular(2),
                ),
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}

class BarChartRen extends StatefulWidget {
  var stepList;
  
  var stringWL;
  
  var weekList;

  BarChartRen({super.key, required this.stepList, required this.stringWL, required this.weekList});

  @override
  State<StatefulWidget> createState() => BarChartRenState();
}

class BarChartRenState extends State<BarChartRen> {
  var stepList;
  
  var weekList;
  
  var stringWL;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Chart(stepList: stepList,weekList: weekList,stringWL: stringWL),
    );
  }
}