class WorkoutGenerationScreen extends ConsumerStatefulWidget {
  const WorkoutGenerationScreen({super.key});
  @override
  ConsumerState<WorkoutGenerationScreen> createState() => _WorkoutGenerationScreenState();
}

class _WorkoutGenerationScreenState extends ConsumerState<WorkoutGenerationScreen> {
  int currentStep = 0;
  String selectedGoal = "muscle_gain";
  String selectedExp = "beginner";
  int selectedDays = 3;

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(workoutProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Plan Generator")),
      body: state.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (plan) {
          if (plan != null) return WorkoutPlanView(plan: plan);
          return Stepper(
            currentStep: currentStep,
            onStepContinue: () {
              if (currentStep < 2) {
                setState(() => currentStep++);
              } else {
                ref.read(workoutProvider.notifier).generatePlan(selectedGoal, selectedExp, selectedDays);
              }
            },
            steps: [
              Step(title: const Text("Goal"), content: DropdownButton<String>(
                value: selectedGoal,
                items: ["fat_loss", "muscle_gain", "strength"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => selectedGoal = v!),
              )),
              Step(title: const Text("Experience"), content: DropdownButton<String>(
                value: selectedExp,
                items: ["beginner", "intermediate", "advanced"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                onChanged: (v) => setState(() => selectedExp = v!),
              )),
              Step(title: const Text("Days Per Week"), content: Slider(
                value: selectedDays.toDouble(), min: 3, max: 6, divisions: 3,
                onChanged: (v) => setState(() => selectedDays = v.toInt()),
              )),
            ],
          );
        },
      ),
    );
  }
}