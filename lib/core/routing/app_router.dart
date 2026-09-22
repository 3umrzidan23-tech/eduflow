import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../../features/splash/presentation/pages/splash_screen.dart';
import '../../features/onboarding/presentation/pages/onboarding_screen.dart';
import '../../features/auth/presentation/pages/login_screen.dart';
import '../../features/auth/presentation/pages/register_screen.dart';

import '../../core/layout/main_layout.dart';
import '../../features/home/presentation/pages/home_screen.dart';
import '../../features/courses/presentation/pages/courses_page.dart';
import '../../features/courses/presentation/pages/course_details_page.dart';
import '../../features/courses/presentation/pages/lecture_player_page.dart';
import '../../features/assignments/presentation/pages/assignments_page.dart';
import '../../features/assignments/presentation/pages/assignment_details_page.dart';
import '../../features/courses/presentation/pages/course_video_player_page.dart';
import '../../features/schedule/presentation/pages/schedule_page.dart';
import '../../features/quiz/presentation/pages/quiz_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/ai_chat/presentation/pages/ai_chat_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/home',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: '/ai_chat',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AiChatPage(),
          ),
        ),
        GoRoute(
          path: '/courses',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: CoursesPage(),
          ),
        ),
        GoRoute(
          path: '/assignments',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AssignmentsPage(),
          ),
        ),
        GoRoute(
          path: '/schedule',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: SchedulePage(),
          ),
        ),
        GoRoute(
          path: '/profile',
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfilePage(),
          ),
        ),
        GoRoute(
          path: '/courses/details/:id',
          builder: (context, state) {
            final courseId = state.pathParameters['id']!;
            return CourseDetailsPage(courseId: courseId);
          },
        ),
        GoRoute(
          path: '/courses/details/:id/lecture/:lectureId',
          builder: (context, state) {
            final courseId = state.pathParameters['id']!;
            final lectureId = state.pathParameters['lectureId']!;
            return LecturePlayerPage(courseId: courseId, lectureId: lectureId);
          },
        ),
        GoRoute(
          path: '/courses/details/:id/video',
          builder: (context, state) {
            final videoId = state.uri.queryParameters['videoId']!;
            final title = state.uri.queryParameters['title'] ?? 'Course Video';
            return CourseVideoPlayerPage(videoId: videoId, title: title);
          },
        ),
        GoRoute(
          path: '/assignments/details/:id',
          builder: (context, state) {
            final assignmentId = state.pathParameters['id']!;
            return AssignmentDetailsPage(assignmentId: assignmentId);
          },
        ),
        GoRoute(
          path: '/quiz/:id',
          builder: (context, state) {
            final courseId = state.pathParameters['id']!;
            return QuizPage(courseId: courseId);
          },
        ),
      ],
    ),
  ],
);
