import 'package:flutter/material.dart';

class ElectricDevices {
  
  final int id;
  final String title;
  final double usagePerUse;
  final Color color;

  ElectricDevices({
    required this.id,
    required this.title,
    required this.usagePerUse,
    required this.color,
  });

}

class ElectricDevicesUsageLog {
  final int deviceid;
  final DateTime timestamp;
  final double usage;

  ElectricDevicesUsageLog({
    required this.deviceid,
    required this.timestamp,
    required this.usage,
  });
}