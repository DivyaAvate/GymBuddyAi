import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/workout_plan_model.dart';
import '../providers/netflix_mode_provider.dart';
import '../widgets/exercise_video_panel.dart';
import '../widgets/workout_controls_overlay.dart';
import '../widgets/rest_timer_overlay.dart';

class NetflixWorkoutScreen extends ConsumerStatefulWidget {
  final List<WorkoutExerciseModel> exercises;
  const NetflixWorkoutScreen({super.key, required this.exercises});

  @override
  ConsumerState<NetflixWorkoutScreen> createState() => _NetflixWorkoutScreenState();
}

class _NetflixWorkoutScreenState extends ConsumerState<NetflixWorkoutScreen> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _onCompleteExercise(int currentIndex) {
    if (currentIndex < widget.exercises.length - 1) {
      // Trigger Rest Timer
      ref.read(netflixModeProvider.notifier).startRest(30); // 30s rest
      
      // Auto-animate to next exercise
      _pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
      ref.read(netflixModeProvider.notifier).nextExercise();
    } else {
      // Workout Finished Logic
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(netflixModeProvider);

    return Scaffold(
      backgroundColor: Colors.black, // Netflix Dark Theme
      body: Stack(
        children: [
          // 1. The Immersive Background (Video/Image)
          PageView.builder(
            controller: _pageController,
            physics: const NeverScrollableScrollPhysics(), // Lock scroll to control via button
            itemCount: widget.exercises.length,
            itemBuilder: (context, index) {
              return ExerciseVideoPanel(exercise: widget.exercises[index]);
            },
          ),

          // 2. The Information & Controls Overlay
          WorkoutControlsOverlay(
            exercise: widget.exercises[state.currentExerciseIndex],
            onComplete: () => _onCompleteExercise(state.currentExerciseIndex),
          ),

          // 3. Rest Timer Overlay (Shows only when resting)
          if (state.isResting)
            RestTimerOverlay(
              seconds: state.remainingRestTime,
              onSkip: () => ref.read(netflixModeProvider.notifier).stopRest(),
            ),
        ],
      ),
    );
  }
}