import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workout_session_model.dart';

class ActiveWorkoutState {
  final int? sessionId;
  final List<ActiveExercise> exercises;
  final DateTime startTime;

  ActiveWorkoutState({this.sessionId, required this.exercises, required this.startTime});
}

class ActiveWorkoutNotifier extends StateNotifier<ActiveWorkoutState?> {
  ActiveWorkoutNotifier() : super(null);

  void startWorkout(int sessionId) {
    state = ActiveWorkoutState(
      sessionId: sessionId,
      exercises: [],
      startTime: DateTime.now(),
    );
  }

  void addExercise(int id, String name) {
    final newList = [...state!.exercises, ActiveExercise(exerciseId: id, name: name, sets: [])];
    state = ActiveWorkoutState(sessionId: state!.sessionId, exercises: newList, startTime: state!.startTime);
  }

  void addSet(int exerciseIndex, double weight, int reps) {
    final exercises = [...state!.exercises];
    exercises[exerciseIndex].sets.add(SetLogModel(weight: weight, reps: reps));
    state = ActiveWorkoutState(sessionId: state!.sessionId, exercises: exercises, startTime: state!.startTime);
  }
}

final activeWorkoutProvider = StateNotifierProvider<ActiveWorkoutNotifier, ActiveWorkoutState?>((ref) => ActiveWorkoutNotifier());