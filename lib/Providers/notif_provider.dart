import 'package:flutter_riverpod/flutter_riverpod.dart';

class ButtonValue extends Notifier<int>{
  
  @override
  int build() {
    return 0;
  }

  void increment(){
    state++;
  }

  void decrement(){
    if(state > 0){
      state--;
    } 
  }
}

final buttonValueProvider = NotifierProvider<ButtonValue,int>(
  ()=>ButtonValue()
);