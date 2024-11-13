import 'package:flutter/material.dart';

class WaterDevices {
  
  final int id;
  final String title;
  final double usagePerUse;
  final Color color;

  
  WaterDevices({
    required this.id,
    required this.title,
    required this.usagePerUse,
    required this.color,
  });

}

class WaterDevicesUsageLog {
  final int deviceid;
  final DateTime timestamp;
  final double usage;

  WaterDevicesUsageLog({
    required this.deviceid,
    required this.timestamp,
    required this.usage,
  });
}

