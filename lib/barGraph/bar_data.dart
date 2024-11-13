class IndividualBar {
  final int date;
  final double value;

  IndividualBar({
    required this.date,
    required this.value,
  });
}

class BarData {
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thrAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;

  BarData({
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thrAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  List<IndividualBar> barData = [];


  void initializeBarData(){
    barData = [
      IndividualBar(date: 0, value: monAmount),
      IndividualBar(date: 1, value: tueAmount),
      IndividualBar(date: 2, value: wedAmount),
      IndividualBar(date: 3, value: thrAmount),
      IndividualBar(date: 4, value: friAmount),
      IndividualBar(date: 5, value: satAmount),
      IndividualBar(date: 6, value: sunAmount),
    ];
  }
}


