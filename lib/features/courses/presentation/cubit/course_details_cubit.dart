import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/course_repository.dart';
import 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  final CourseRepository _courseRepository;

  CourseDetailsCubit({CourseRepository? courseRepository})
      : _courseRepository = courseRepository ?? CourseRepositoryImpl(),
        super(CourseDetailsInitial());

  Future<void> loadCourseDetails(String id) async {
    emit(CourseDetailsLoading());
    try {
      final course = await _courseRepository.getCourseDetails(id);
      emit(CourseDetailsLoaded(course: course));
    } catch (e) {
      emit(CourseDetailsFailure(message: 'Failed to load details: ${e.toString()}'));
    }
  }
}
