import 'package:first_app/model/electric_devices.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

class Electricdeviceslist extends Notifier<List<ElectricDevices>>{
  
  @override
  List<ElectricDevices> build(){
    return [
      ElectricDevices(id: 1, title: "Air Conditioner", usagePerUse: 3.5, color: Colors.blue),
      ElectricDevices(id: 2, title: 'Washing Machine', usagePerUse: 140.4, color: Colors.red),
      ElectricDevices(id: 3, title: 'Lights', usagePerUse: 30, color: Colors.yellow),
      ElectricDevices(id: 4, title: 'Computer', usagePerUse: 0.42, color: Colors.green),
      ElectricDevices(id: 5, title: 'Phones', usagePerUse: 0.035, color: Colors.pink),
    ];
  }
   
  addDevice(ElectricDevices newDevice){
    state = [...state,newDevice];
  }

  removeDevice(int deviceId){
    state = state.where((device) => device.id != deviceId).toList();
  }
  
  updateDevice(ElectricDevices updatedDevice) {
    state = [
      for (var device in state)
        if (device.id == updatedDevice.id) updatedDevice else device,
    ];
  }
}

final electricDevicesListProvider = NotifierProvider<Electricdeviceslist,List<ElectricDevices>>(
  () => Electricdeviceslist()
);


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