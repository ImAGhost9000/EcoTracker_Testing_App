import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:first_app/model/electric_devices.dart';
import 'Providers/electricdevices_provider.dart';
import 'dart:math';

class ElectricalUsageForm extends ConsumerStatefulWidget {
  const ElectricalUsageForm({super.key});

  @override
  ElectricalUsageFormState createState() => ElectricalUsageFormState();
}

class ElectricalUsageFormState extends ConsumerState<ElectricalUsageForm> {
  final Map<int, TextEditingController> deviceInputControllers = {};

  @override
  void dispose() {
    for (var controller in deviceInputControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final electricDevices = ref.watch(electricDevicesListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Usage Testing')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: electricDevices.length,
                  itemBuilder: (context, index) {
                    final device = electricDevices[index];

                    deviceInputControllers.putIfAbsent(device.id, () => TextEditingController());

                    return Card(
                      color: Colors.yellow,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Stack(
                        children: [
                          ListTile(
                            title: Text(device.title),
                            subtitle: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text("Usage: ${device.usagePerUse} kWh"),
                              ],
                            ),
                            trailing: SizedBox(
                              width: 160,
                              child: TextFormField(
                                controller: deviceInputControllers[device.id],
                                decoration: const InputDecoration(
                                  labelText: 'Hours Used',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),

                          Positioned(
                            top: 28,
                            right: -12,
                            child: IconButton(
                              icon: const Icon(Icons.close, color: Colors.black, size: 15),
                              onPressed: () {
                                ref.read(electricDevicesListProvider.notifier).removeDevice(device.id);
                              },
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),

                          Positioned(
                            top: -3,
                            right: -12,
                            child: IconButton(
                              onPressed: () => editDialog(context,device), 
                              icon: const Icon(Icons.edit, size: 15),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),

                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => submitUsage(), 
                child: const Text('Submit'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddDeviceDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void submitUsage() {
    final devices = ref.read(electricDevicesListProvider);
    final usagesNotifier = ref.read(electricUsagesListProvider.notifier);
    final now = DateTime.now();

    for (var device in devices) {
      final controller = deviceInputControllers[device.id];

      if (controller == null || controller.text.isEmpty) {
        continue;
      }

      final inputNumber = double.tryParse(controller.text) ?? 0;
      final usage = calculateDeviceUsage(device.usagePerUse, inputNumber);

      usagesNotifier.addUsageLog(
        ElectricDevicesUsageLog(deviceid: device.id, timestamp: now, usage: usage),
      );
    }
  }

  void showAddDeviceDialog(BuildContext context) {
    final devicesNotifier = ref.read(electricDevicesListProvider.notifier);
    final titleController = TextEditingController();
    final usageController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Device'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Device Name"),
              ),
              TextField(
                controller: usageController,
                decoration: const InputDecoration(labelText: "Usage per Use (kWh)"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final title = titleController.text;
                final usage = double.tryParse(usageController.text) ?? 0;
                final color = getRandomColor();

                if (title.isNotEmpty && usage > 0) {
                  devicesNotifier.addDevice(
                    ElectricDevices(
                      id: DateTime.now().millisecondsSinceEpoch,
                      title: title,
                      usagePerUse: usage,
                      color: color,
                    ),
                  );
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void editDialog(BuildContext context, ElectricDevices device) {
  final devicesNotifier = ref.read(electricDevicesListProvider.notifier);

  
  final titleController = TextEditingController(text: device.title);
  final usageController = TextEditingController(text: device.usagePerUse.toString());

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Edit Device'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Device Name"),
            ),
            TextField(
              controller: usageController,
              decoration: const InputDecoration(labelText: "Usage per Use (kWh)"),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final title = titleController.text;
              final usage = double.tryParse(usageController.text) ?? 0;

              if (title.isNotEmpty && usage > 0) {
                // Update the device with new title and usage values
                devicesNotifier.updateDevice(
                  ElectricDevices(
                    id: device.id,  // Keep the same ID to identify the device
                    title: title,    // New title from text field
                    usagePerUse: usage,  // New usage from text field
                    color: device.color,  // Retain the current color
                  ),
                );
                Navigator.of(context).pop(); // Close the dialog
              }
            },
            child: const Text('Edit'),
          ),
        ],
      );
    },
  );
}


  void removeDevice(int deviceId) {
    final devicesNotifier = ref.read(electricDevicesListProvider.notifier);
    devicesNotifier.removeDevice(deviceId);
    setState(() {
      deviceInputControllers.remove(deviceId);
    });
  }
}

double calculateDeviceUsage(double baseUsage, double numHours) {
  if (numHours <= 0 || numHours > 24) return 0;
  return baseUsage * numHours;
}

Color getRandomColor() {
  final Random random = Random();
  const int minBrightness = 100;

  int red = minBrightness + random.nextInt(256 - minBrightness);
  int green = minBrightness + random.nextInt(256 - minBrightness);
  int blue = minBrightness + random.nextInt(256 - minBrightness);

  return Color.fromARGB(255, red, green, blue);
}

void main() {
  runApp(const ProviderScope(child: MaterialApp(home: ElectricalUsageForm())));
}
