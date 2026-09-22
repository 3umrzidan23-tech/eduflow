import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // The Splash screen must NOT simply wait for an arbitrary delay.
    // It initializes the app and determines authentication state.
    
    // Check SharedPreferences for onboarding state
    final prefs = await SharedPreferences.getInstance();
    final hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;

    // Check Auth State
    final user = FirebaseAuth.instance.currentUser;
    
    // Optional minimum delay for branding visibility
    await Future.delayed(const Duration(seconds: 1));
    
    if (!mounted) return;

    if (user != null) {
      // Navigate to Home
      context.go('/home');
    } else {
      if (hasSeenOnboarding) {
        context.go('/login');
      } else {
        context.go('/onboarding');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E293B), // Dark blue from the presentation image
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // EduFlow logo (using Flutter icon as placeholder)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.layers,
                size: 64,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 24),
            // App name
            const Text(
              'EduFlow',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            // Short tagline
            const Text(
              'Empowering your academic journey',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 48),
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          ],
        ),
      ),
    );
  }
}
