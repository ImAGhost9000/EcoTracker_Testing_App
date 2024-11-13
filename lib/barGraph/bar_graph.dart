import 'package:first_app/barGraph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatefulWidget {
  final List weeklySummary;
  final Color barColor;
  const MyBarGraph({
    super.key,
    required this.weeklySummary,
    required this.barColor,
  });

  @override
  State<MyBarGraph> createState() => _MyBarGraphState();
}

class _MyBarGraphState extends State<MyBarGraph> {
  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(
      monAmount: widget.weeklySummary[0], 
      tueAmount: widget.weeklySummary[1], 
      wedAmount: widget.weeklySummary[2], 
      thrAmount: widget.weeklySummary[3], 
      friAmount: widget.weeklySummary[4], 
      satAmount: widget.weeklySummary[5], 
      sunAmount: widget.weeklySummary[6],
    );

    myBarData.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 100, // Maximum Y value
        minY: 0,   // Minimum Y value

        backgroundColor: const Color.fromARGB(255, 40, 39, 39),
        gridData: FlGridData(
          drawVerticalLine: false,
          drawHorizontalLine: true,
          horizontalInterval: 20,
          getDrawingHorizontalLine: (value) {
            return const FlLine(
              color: Color.fromARGB(255, 73, 72, 72),
              strokeWidth: 1,
            );
          },
        ),

        borderData: FlBorderData(
          show: false,
        ),

        titlesData: FlTitlesData(
          show: true,
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(
            sideTitles: 
              SideTitles(
                showTitles: true,
                reservedSize: 55,
                interval: 20,
                getTitlesWidget: (value, meta) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        
                        value.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                        ), 
                    ),
                  );
                },

                ),
            ), 
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true, 
              reservedSize: 35,
              getTitlesWidget: (value, meta) {
                return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                        getDayLabel(value.toInt()),
                        style: const TextStyle(
                          color: Colors.green,
                          fontSize: 12,
                          fontWeight: FontWeight.bold
                      ), 
                    ),
                  );
              },
              )
            ),
        ),

      

        barGroups: myBarData.barData.map(
          (data) => BarChartGroupData(
            x: data.date,
            barRods: [
              BarChartRodData(
                toY: data.value, 
                color: widget.barColor, 
                width: 25,
                borderRadius: BorderRadius.circular(20)
              )],
            ),
        ).toList(),

    
      ), 
      swapAnimationDuration: const Duration(milliseconds: 500), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    ); 
  }
}


String getDayLabel(int value){
  switch(value){
        case 0:
        return 'M';   // Monday
      case 1:
        return 'T';   // Tuesday
      case 2:
        return 'W';   // Wednesday
      case 3:
        return 'Th';  // Thursday
      case 4:
        return 'F';   // Friday
      case 5:
        return 'Sat';  // Saturday
      case 6:
        return 'S';  // Sunday
      default:
        return '';
  }
}

class Bargraph extends StatefulWidget {
  const Bargraph({
    super.key,
    required this.weeklyUsage,
    required this.barColor,
    required this.unitMeasurement,
  });

  final List<double> weeklyUsage;
  final Color barColor;
  final String unitMeasurement;

  @override
  State<Bargraph> createState() => _BargraphState();
}

class _BargraphState extends State<Bargraph> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 380,
        height: 200,
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 40, 39, 39),
          borderRadius: BorderRadius.circular(8), 
        ),
          
        alignment: Alignment.center, 
        child:
          Column(
            
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.unitMeasurement,
                  textAlign: TextAlign.left,
                   style: TextStyle(
                    color: widget.barColor, 
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                    ),
                ),
              ),
              const SizedBox(height: 5,),
              Expanded(child:MyBarGraph(weeklySummary: widget.weeklyUsage,barColor: widget.barColor,),)
            
            ]
            
          )
          
      );
  }
}


