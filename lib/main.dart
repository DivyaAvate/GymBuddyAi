import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'features/auth/presentation/pages/login_page.dart';

void main() {
  // Ensure Flutter bindings are initialized before anything else
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // ProviderScope is mandatory for Riverpod to work.
    // It stores the state of all providers used in the app.
    const ProviderScope(
      child: GymBuddyApp(),
    ),
  );
}

class GymBuddyApp extends StatelessWidget {
  const GymBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymBuddy AI',
      debugShowCheckedModeBanner: false,
      
      // Theme Configuration
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 50), // Full width buttons
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),

      // Set the Login Page as the starting screen
      home: const LoginPage(),
    );
  }
}