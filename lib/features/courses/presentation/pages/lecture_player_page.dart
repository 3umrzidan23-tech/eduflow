import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../domain/repositories/course_repository.dart';
import '../../domain/entities/course.dart';

class LecturePlayerPage extends StatefulWidget {
  final String courseId;
  final String lectureId;

  const LecturePlayerPage({super.key, required this.courseId, required this.lectureId});

  @override
  State<LecturePlayerPage> createState() => _LecturePlayerPageState();
}

class _LecturePlayerPageState extends State<LecturePlayerPage> {
  final CourseRepository _courseRepository = CourseRepositoryImpl();
  Course? _course;
  Lecture? _lecture;
  bool _isLoading = true;
  YoutubePlayerController? _youtubeController;

  @override
  void initState() {
    super.initState();
    _loadLecture();
  }

  Future<void> _loadLecture() async {
    try {
      final course = await _courseRepository.getCourseDetails(widget.courseId);
      final lecture = course.lectures.firstWhere((l) => l.id == widget.lectureId);
      
      setState(() {
        _course = course;
        _lecture = lecture;
        _isLoading = false;
        if (course.youtubeVideoId != null) {
          _youtubeController = YoutubePlayerController.fromVideoId(
            videoId: course.youtubeVideoId!,
            autoPlay: false,
            params: const YoutubePlayerParams(
              showControls: true,
              mute: false,
            ),
          );
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _youtubeController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_lecture == null || _course == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Failed to load lecture.')),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E293B)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Lecture', 
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_youtubeController != null)
            YoutubePlayer(
              controller: _youtubeController!,
            )
          else
            _buildMockVideoPlayer(),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _lecture!.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.grey, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      _lecture!.duration,
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                if (!_lecture!.isCompleted)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Lecture marked as completed!')),
                        );
                        context.pop(); 
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E293B),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Mark as Completed', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMockVideoPlayer() {
    return Container(
      width: double.infinity,
      height: 220,
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.play_arrow, color: Colors.white, size: 48),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Video Available',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

