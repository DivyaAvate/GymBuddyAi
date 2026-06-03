import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/active_workout_provider.dart';

class ActiveWorkoutScreen extends ConsumerWidget {
  const ActiveWorkoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workout = ref.watch(activeWorkoutProvider);

    if (workout == null) return const Scaffold(body: Center(child: Text("No active workout")));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracking Session"),
        actions: [
          TextButton(
            onPressed: () => _finishWorkout(context, ref),
            child: const Text("FINISH", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: workout.exercises.length,
        itemBuilder: (context, exIndex) {
          final exercise = workout.exercises[exIndex];
          return Card(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(title: Text(exercise.name, style: const TextStyle(fontWeight: FontWeight.bold))),
                ...exercise.sets.map((set) => ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: Text("${set.weight} kg x ${set.reps} reps"),
                  trailing: set.isPR ? const Icon(Icons.emoji_events, color: Colors.amber) : null,
                )),
                TextButton.icon(
                  onPressed: () => _showAddSetDialog(context, ref, exIndex),
                  icon: const Icon(Icons.add),
                  label: const Text("Add Set"),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () { /* Logic to pick exercise from Library */ },
        label: const Text("Add Exercise"),
        icon: const Icon(Icons.add),
      ),
    );
  }

  void _showAddSetDialog(BuildContext context, WidgetRef ref, int exIndex) {
    // Controller and Dialog Logic to call ref.read(activeWorkoutProvider.notifier).addSet(...)
  }

  void _finishWorkout(BuildContext context, WidgetRef ref) {
    // Call Backend API /finish/:id and clear provider
  }
}