import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Welcome to EduFlow',
      'description': 'Your personalized academic platform designed to streamline your learning experience.',
      'icon': 'school',
    },
    {
      'title': 'Track Your Progress',
      'description': 'Keep an eye on your courses, assignments, and schedule all in one place.',
      'icon': 'trending_up',
    },
    {
      'title': 'AI Study Assistant',
      'description': 'Get instant help with your studies using our integrated AI assistant.',
      'icon': 'auto_awesome',
    },
  ];

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    if (!mounted) return;
    context.go('/login');
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          index == 0
                              ? Icons.school
                              : index == 1
                                  ? Icons.trending_up
                                  : Icons.auto_awesome,
                          size: 120,
                          color: const Color(0xFF1E293B),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          _onboardingData[index]['title']!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _onboardingData[index]['description']!,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Indicators
                  Row(
                    children: List.generate(
                      _onboardingData.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 8),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? const Color(0xFF1E293B)
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  // Buttons
                  if (_currentPage == _onboardingData.length - 1)
                    ElevatedButton(
                      onPressed: _completeOnboarding,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E293B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text('Get Started'),
                    )
                  else
                    Row(
                      children: [
                        TextButton(
                          onPressed: _completeOnboarding,
                          child: const Text(
                            'Skip',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _nextPage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E293B),
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Next'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
