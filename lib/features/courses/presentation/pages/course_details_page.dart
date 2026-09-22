import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/course_details_cubit.dart';
import '../cubit/course_details_state.dart';
import '../../domain/entities/course.dart';

class CourseDetailsPage extends StatelessWidget {
  final String courseId;

  const CourseDetailsPage({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CourseDetailsCubit()..loadCourseDetails(courseId),
      child: const CourseDetailsView(),
    );
  }
}

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E293B)),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
          builder: (context, state) {
            if (state is CourseDetailsLoading || state is CourseDetailsInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CourseDetailsFailure) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
            } else if (state is CourseDetailsLoaded) {
              final course = state.course;
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.only(left: 24.0, right: 24.0, bottom: 100.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.menu_book, size: 50, color: Colors.blueAccent),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          course.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          course.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: Colors.blue.withValues(alpha: 0.2),
                              child: const Icon(Icons.person, size: 16, color: Colors.blueAccent),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              course.instructor,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${course.completedLectures} / ${course.totalLectures} Lectures Completed',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            Text(
                              '${course.completionPercentage}%',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E293B),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: course.completionPercentage / 100,
                          backgroundColor: Colors.grey[300],
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                          borderRadius: BorderRadius.circular(4),
                          minHeight: 8,
                        ),
                        const SizedBox(height: 24),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: course.lectures.length,
                          separatorBuilder: (context, index) => const Divider(height: 32),
                          itemBuilder: (context, index) {
                            final lecture = course.lectures[index];
                            return _LectureTile(courseId: course.id, lecture: lecture);
                          },
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 24,
                    right: 24,
                    bottom: 24,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (course.youtubeVideoId != null) ...[
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.push('/courses/details/${course.id}/video?videoId=${course.youtubeVideoId}&title=${Uri.encodeComponent(course.title)}');
                              },
                              icon: const Icon(Icons.play_circle_fill, color: Colors.white),
                              label: const Text('Watch Video', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.push('/quiz/${course.id}');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1E293B),
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text('Take Quiz', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}

class _LectureTile extends StatelessWidget {
  final String courseId;
  final Lecture lecture;

  const _LectureTile({required this.courseId, required this.lecture});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/courses/details/$courseId/lecture/${lecture.id}');
      },
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: lecture.isCompleted 
                  ? Colors.green.withValues(alpha: 0.1) 
                  : Colors.blue.withValues(alpha: 0.1),
            ),
            child: Icon(
              lecture.isCompleted ? Icons.check : Icons.play_arrow,
              color: lecture.isCompleted ? Colors.green : Colors.blue,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              lecture.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: lecture.isCompleted ? Colors.grey[600] : const Color(0xFF1E293B),
              ),
            ),
          ),
          Text(
            lecture.duration,
            style: TextStyle(
              color: Colors.grey[500],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
