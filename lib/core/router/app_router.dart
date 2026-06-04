import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/home/presentation/pages/main_layout.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/workout/presentation/pages/workout_generation_screen.dart';
import '../../features/workout/presentation/pages/active_workout_screen.dart';
import '../../features/workout/presentation/pages/exercise_detail_page.dart';
import '../../features/workout/presentation/pages/exercise_list_page.dart';
import '../../features/workout/presentation/pages/netflix_workout_screen.dart';
import '../../features/steps/presentation/pages/steps_screen.dart';
import '../../features/ai_coach/presentation/pages/chat_screen.dart';
import '../../features/profile/presentation/pages/dashboard_page.dart';
import '../../features/profile/presentation/pages/achievements_page.dart';
import '../../features/profile/presentation/pages/leaderboard_page.dart';
import '../../features/progress/presentation/pages/progress_dashboard_page.dart';
import '../../features/recovery/presentation/pages/recovery_dashboard_page.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  debugLogDiagnostics: true,

  // Global error page
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text(
        'Page not found: ${state.uri}',
        style: const TextStyle(color: Colors.white),
      ),
    ),
  ),

  routes: [
    // ─── Auth Routes ───────────────────────────────────────────
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),

    // ─── Main Shell (Bottom Nav) ───────────────────────────────
    ShellRoute(
      builder: (context, state, child) => MainLayout(child: child),
      routes: [
        GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/workout',
          name: 'workout',
          builder: (context, state) => const WorkoutGenerationScreen(),
        ),
        GoRoute(
          path: '/steps',
          name: 'steps',
          builder: (context, state) => const StepsScreen(),
        ),
        GoRoute(
          path: '/coach',
          name: 'coach',
          builder: (context, state) => const ChatScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/progress',
          name: 'progress',
          builder: (context, state) => const ProgressDashboardPage(),
        ),
        GoRoute(
          path: '/recovery',
          name: 'recovery',
          builder: (context, state) => const RecoveryDashboardPage(),
        ),
        GoRoute(
          path: '/achievements',
          name: 'achievements',
          builder: (context, state) => const AchievementsPage(),
        ),
        GoRoute(
          path: '/leaderboard',
          name: 'leaderboard',
          builder: (context, state) => const LeaderboardPage(),
        ),
      ],
    ),

    // ─── Standalone Routes (no bottom nav) ────────────────────
    GoRoute(
      path: '/active-workout',
      name: 'active-workout',
      builder: (context, state) => const ActiveWorkoutScreen(),
    ),
    GoRoute(
      path: '/exercise-list',
      name: 'exercise-list',
      builder: (context, state) => const ExerciseListPage(),
    ),
    GoRoute(
      path: '/exercise-detail',
      name: 'exercise-detail',
      builder: (context, state) {
        // Pass exercise id via extra or queryParam
        final exerciseId = state.uri.queryParameters['id'] ?? '';
        return ExerciseDetailPage(exerciseId: exerciseId);
      },
    ),
    GoRoute(
      path: '/cinematic-workout',
      name: 'cinematic-workout',
      builder: (context, state) => const NetflixWorkoutScreen(),
    ),
  ],
);