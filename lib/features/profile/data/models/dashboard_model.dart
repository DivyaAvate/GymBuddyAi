class DashboardModel {
  final String userName;
  final int xp;
  final int streak;
  final int steps;
  final int recoveryScore;
  final List<ChartData> activity;
  final String? todayWorkoutName;

  DashboardModel({
    required this.userName, required this.xp, required this.streak,
    required this.steps, required this.recoveryScore, required this.activity,
    this.todayWorkoutName,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {
    return DashboardModel(
      userName: json['user']['displayName'] ?? "User",
      xp: json['user']['xp'] ?? 0,
      streak: json['user']['streak_count'] ?? 0,
      steps: json['stats']['steps'],
      recoveryScore: json['stats']['recoveryScore'],
      todayWorkoutName: json['todayWorkout']?['dayName'],
      activity: (json['weeklyActivity'] as List)
          .map((e) => ChartData(e['date'], double.parse(e['volume'].toString())))
          .toList(),
    );
  }
}

class ChartData {
  final String date;
  final double value;
  ChartData(this.date, this.value);
}