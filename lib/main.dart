import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
await dotenv.load(fileName: ".env");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(); // uncomment when Firebase added

  runApp(
    const ProviderScope(
      child: GymBuddyApp(),
    ),
  );
}

class GymBuddyApp extends StatelessWidget {
  const GymBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GymBuddy AI',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      theme: AppTheme.dark(),
    );
  }
}