import 'package:first_app/Providers/notif_provider.dart';
import 'package:first_app/barGraph/bar_graph.dart';
import 'package:flutter/material.dart';
import 'package:first_app/circleGraph/circle_graph.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  List<double> electricalUsage = [20.0, 75.0, 97.0, 89.0, 30.0, 80.0, 20.0];
  List<double> waterUsage = [30.0, 23.0, 60.0, 85.0, 33.0, 45.0, 65.0];

  
  // Define titles and colors for each PieChartSection
  final List<Map<String, dynamic>> electricDevices = [
    {
      'title': 'Computer',
      'color': Colors.blue,
      'value': 90.0,
    },
    {
      'title': 'Washing Machine',
      'color': Colors.red,
      'value': 50.0,
    },
    {
      'title': 'Lights',
      'color': Colors.yellow,
      'value': 30.0,
    },
    {
      'title': 'Aircon',
      'color': Colors.green,
      'value': 90.0,
    },
  ];

  final List<Map<String, dynamic>> waterDevices = [
    {
      'title': 'Faucet',
      'color': Colors.blue,
      'value': 90.0,
    },
    {
      'title': 'Shower',
      'color': Colors.red,
      'value': 50.0,
    },
    {
      'title': 'Gardening Hose',
      'color': Colors.yellow,
      'value': 30.0,
    },
    {
      'title': 'Toilet',
      'color': Colors.green,
      'value': 90.0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final buttonValue = ref.watch(buttonValueProvider);    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              // Bar graphs for electrical and water usage
              SizedBox(
                height: 200,
                child: Bargraph(
                  weeklyUsage: electricalUsage,
                  barColor: Colors.yellow,
                  unitMeasurement: 'KwH = Kilowatt per Liter',
                ),
              ),
              
              SizedBox(
                height: 200,
                child: Bargraph(
                  weeklyUsage: waterUsage,
                  barColor: Colors.blue,
                  unitMeasurement: 'GaL = Gallons Per Liter',
                ),
              ),
              // Pie chart
              
              Piegraph(pieChartSections: electricDevices, unit: 'Kwh'),
              Piegraph(pieChartSections: waterDevices, unit: 'GaL'),
              // Labels for each section of the pie chart
              Text(
                buttonValue.toString(),
                style: const TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
            ],
          ),
        ),
      ),
      floatingActionButton: Stack(
        children: [
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: () => ref.read(buttonValueProvider.notifier).increment(),
              child: const Icon(Icons.add),
            ),
          ),

          Positioned(
            bottom: 70,
            right: 10,
            child: FloatingActionButton(
              onPressed: () => ref.read(buttonValueProvider.notifier).decrement(),
              child: const Icon(Icons.minimize),
            ),
          ),
        ],
      )
    );
  }
}

