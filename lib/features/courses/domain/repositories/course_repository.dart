import '../entities/course.dart';
import '../../../../core/config/video_config.dart';

abstract class CourseRepository {
  Future<List<Course>> getCourses();
  Future<Course> getCourseDetails(String id);
}

class CourseRepositoryImpl implements CourseRepository {
  @override
  Future<List<Course>> getCourses() async {
    // Mocking a network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Course(
        id: '1', 
        title: 'Database Systems', 
        description: 'Learn the fundamentals of database design and SQL.',
        instructor: 'Dr. Ali',
        youtubeVideoId: VideoConfig.extractVideoId(VideoConfig.databaseVideoUrl),
        completionPercentage: 85, 
        totalLectures: 12, 
        completedLectures: 10,
        lectures: [
          Lecture(id: 'l1', title: '01 Intro to Databases', duration: '15:20', isCompleted: true, videoUrl: 'https://www.youtube.com/watch?v=k1'),
          Lecture(id: 'l2', title: '02 Relational Algebra', duration: '20:10', isCompleted: true, videoUrl: 'https://www.youtube.com/watch?v=k2'),
          Lecture(id: 'l3', title: '03 Normalization', duration: '18:45', isCompleted: false, videoUrl: 'https://www.youtube.com/watch?v=k3'),
        ],
      ),
      Course(
        id: '2', 
        title: 'Flutter Development', 
        description: 'Master cross-platform mobile development with Flutter.',
        instructor: 'Ahmed Hassan',
        youtubeVideoId: VideoConfig.extractVideoId(VideoConfig.flutterVideoUrl),
        completionPercentage: 73, 
        totalLectures: 11, 
        completedLectures: 8,
        lectures: [
          Lecture(id: 'l1', title: '01 Intro to Flutter', duration: '10:00', isCompleted: true, videoUrl: 'https://www.youtube.com/watch?v=1'),
          Lecture(id: 'l2', title: '02 Widgets & Layouts', duration: '25:30', isCompleted: true, videoUrl: 'https://www.youtube.com/watch?v=2'),
          Lecture(id: 'l3', title: '03 State Management', duration: '30:15', isCompleted: false, videoUrl: 'https://www.youtube.com/watch?v=3'),
        ],
      ),
      Course(
        id: '3', 
        title: 'Web Technology', 
        description: 'Modern web development with HTML, CSS, and JS.',
        instructor: 'Eng. Sara',
        youtubeVideoId: VideoConfig.extractVideoId(VideoConfig.webVideoUrl),
        completionPercentage: 64, 
        totalLectures: 10, 
        completedLectures: 6,
      ),
      Course(
        id: '4', 
        title: 'Software Engineering', 
        description: 'Principles of building reliable software systems.',
        instructor: 'Dr. Tarek',
        youtubeVideoId: VideoConfig.extractVideoId(VideoConfig.softwareEngineeringVideoUrl),
        completionPercentage: 78, 
        totalLectures: 20, 
        completedLectures: 15,
      ),
      Course(
        id: '5', 
        title: 'Computer Networks', 
        description: 'Understand data communication and networking concepts.',
        instructor: 'Dr. Youssef',
        youtubeVideoId: VideoConfig.extractVideoId(VideoConfig.networksVideoUrl),
        completionPercentage: 0, 
        totalLectures: 15, 
        completedLectures: 0,
      ),
      Course(
        id: '6', 
        title: 'Operating Systems', 
        description: 'Learn about processes, memory management, and file systems.',
        instructor: 'Eng. Khaled',
        youtubeVideoId: VideoConfig.extractVideoId(VideoConfig.operatingSystemsVideoUrl),
        completionPercentage: 0, 
        totalLectures: 14, 
        completedLectures: 0,
      ),
      Course(
        id: '7', 
        title: 'Data Structures & Algorithms', 
        description: 'Master core CS fundamentals for efficient problem solving.',
        instructor: 'Dr. Mona',
        youtubeVideoId: VideoConfig.extractVideoId(VideoConfig.dataStructuresVideoUrl),
        completionPercentage: 0, 
        totalLectures: 25, 
        completedLectures: 0,
      ),
    ];
  }

  @override
  Future<Course> getCourseDetails(String id) async {
    final courses = await getCourses();
    return courses.firstWhere((c) => c.id == id, orElse: () => courses.first);
  }
}
