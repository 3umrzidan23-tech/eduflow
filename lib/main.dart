import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/routing/app_router.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization error or not configured: $e');
  }
  runApp(const EduFlowApp());
}

class EduFlowApp extends StatelessWidget {
  const EduFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EduFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E293B), // Match splash screen branding
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
