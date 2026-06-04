import 'package:flutter/material.dart';

import 'package:gymbuddy_ai/core/constants/app_colors.dart';
import 'package:gymbuddy_ai/features/home/presentation/pages/home_page.dart';

// FIX: Use actual existing pages from your project
import 'package:gymbuddy_ai/features/workout/presentation/pages/workout_generation_screen.dart';
import 'package:gymbuddy_ai/features/profile/presentation/pages/dashboard_page.dart';

// TODO: Replace these with real files when you create them
// import 'package:gymbuddy_ai/features/progress/presentation/pages/progress_dashboard_page.dart';
// import 'package:gymbuddy_ai/features/ai_coach/presentation/pages/chat_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  late final List<Widget> _screens = [
    const HomePage(),

    // temporary placeholders (replace when pages exist)
    const WorkoutGenerationScreen(),
    const DashboardPage(),
    const HomePage(), // AI Coach placeholder
    const DashboardPage(), // Profile placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPrimary,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.bgPrimary,
        selectedItemColor: AppColors.accentGreen,
        unselectedItemColor: AppColors.textMuted,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "Workout",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: "Progress",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome),
            label: "AI Coach",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}