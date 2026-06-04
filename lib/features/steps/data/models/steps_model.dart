class StepTrend {
  final DateTime date;
  final int steps;

  const StepTrend({
    required this.date,
    required this.steps,
  });

  factory StepTrend.fromJson(Map<String, dynamic> json) => StepTrend(
        date:  DateTime.parse(json['date'] as String),
        steps: json['steps'] as int,
      );

  Map<String, dynamic> toJson() => {
        'date':  date.toIso8601String(),
        'steps': steps,
      };
}