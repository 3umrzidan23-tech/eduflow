import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/courses_cubit.dart';
import '../cubit/courses_state.dart';
import '../../domain/entities/course.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CoursesCubit()..loadCourses(),
      child: const CoursesView(),
    );
  }
}

class CoursesView extends StatelessWidget {
  const CoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Courses List',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) {
            if (state is CoursesLoading || state is CoursesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CoursesFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<CoursesCubit>().loadCourses(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is CoursesLoaded) {
              return RefreshIndicator(
                onRefresh: () => context.read<CoursesCubit>().loadCourses(),
                child: ListView.separated(
                  padding: const EdgeInsets.all(24.0),
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: state.courses.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final course = state.courses[index];
                    return _CourseCard(course: course);
                  },
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/courses/details/${course.id}');
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${course.completionPercentage}% Completed',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    course.title,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.instructor,
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              height: 60,
              width: 60,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: course.completionPercentage / 100,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    strokeWidth: 6,
                  ),
                  Center(
                    child: Text(
                      '${course.completionPercentage}%',
                      style: const TextStyle(
                        color: Color(0xFF1E293B),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
