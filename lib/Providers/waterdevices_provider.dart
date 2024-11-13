
import 'package:first_app/model/water_devices.dart';
import 'package:first_app/model/electric_devices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class WaterDevicesList extends Notifier<List<WaterDevices>>{
  
  @override
  List<WaterDevices> build(){
    return [
      WaterDevices(id: 1, title: 'Shower', usagePerUse: 2.1, color: Colors.blue),
      WaterDevices(id: 2, title: 'Washing Machine', usagePerUse: 5, color: Colors.red),
      WaterDevices(id: 3, title: 'Toilet', usagePerUse: 3, color: Colors.yellow),
      WaterDevices(id: 4, title: 'Dishwasher', usagePerUse: 4, color: Colors.green),
    ];
  }


  addDevice(WaterDevices newDevice){
    state = [...state,newDevice];
  }

  removeDevice(int deviceId){
    state = state.where((device) => device.id != deviceId).toList();
  }
  
  updateDevice(WaterDevices updatedDevice) {
    state = [
      for (var device in state)
        if (device.id == updatedDevice.id) updatedDevice else device,
    ];
  }
   //add functions here to handle data
  
}

final waterDevicesListProvider = NotifierProvider<WaterDevicesList,List<WaterDevices>>(
  () => WaterDevicesList()
);


class Waterusageslist extends Notifier<List<WaterDevicesUsageLog>>{
  @override
  List<WaterDevicesUsageLog>build(){
    return[];
  }

  addUsageLog(WaterDevicesUsageLog newUsage){
    state = [...state,newUsage];
  }
}

final waterUsagesListProvider = NotifierProvider<Waterusageslist,List<WaterDevicesUsageLog>>(() => Waterusageslist(),);

class Electricusageslist extends Notifier<List<ElectricDevicesUsageLog>>{
  @override
  List<ElectricDevicesUsageLog>build(){
    return[];
  }

  addUsageLog(ElectricDevicesUsageLog newUsage){
    state = [...state,newUsage];
  }
}

final electricUsagesListProvider = NotifierProvider<Electricusageslist,List<ElectricDevicesUsageLog>>(() => Electricusageslist(),);