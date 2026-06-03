// lib/features/workout/presentation/widgets/exercise_video_panel.dart
class ExerciseVideoPanel extends StatelessWidget {
  final WorkoutExerciseModel exercise;
  const ExerciseVideoPanel({super.key, required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: NetworkImage("https://img.youtube.com/vi/${exercise.videoId}/maxresdefault.jpg"),
          fit: BoxImageFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.4), BlendMode.darken),
        ),
      ),
      child: const Center(child: Icon(Icons.play_circle_fill, size: 80, color: Colors.white70)),
    );
  }
}