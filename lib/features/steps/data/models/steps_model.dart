class StepTrend {
  final DateTime date;
  final int steps;
  final double calories;

  StepTrend({required this.date, required this.steps}) 
    : calories = steps * 0.04; // Simple estimate: 0.04 cal per step
}