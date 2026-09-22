class Course {
  final String id;
  final String title;
  final String description;
  final String instructor;
  final String? imageUrl;
  final String? youtubeVideoId;
  final int completionPercentage;
  final int totalLectures;
  final int completedLectures;
  final List<Lecture> lectures;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.instructor,
    this.imageUrl,
    this.youtubeVideoId,
    required this.completionPercentage,
    required this.totalLectures,
    required this.completedLectures,
    this.lectures = const [],
  });
}

class Lecture {
  final String id;
  final String title;
  final String duration;
  final bool isCompleted;
  final String videoUrl;

  Lecture({
    required this.id,
    required this.title,
    required this.duration,
    required this.isCompleted,
    required this.videoUrl,
  });
}
