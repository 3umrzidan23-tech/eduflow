import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/course_repository.dart';
import 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  final CourseRepository _courseRepository;

  CoursesCubit({CourseRepository? courseRepository})
      : _courseRepository = courseRepository ?? CourseRepositoryImpl(),
        super(CoursesInitial());

  Future<void> loadCourses() async {
    emit(CoursesLoading());
    try {
      final courses = await _courseRepository.getCourses();
      emit(CoursesLoaded(courses: courses));
    } catch (e) {
      emit(CoursesFailure(message: 'Failed to load courses: ${e.toString()}'));
    }
  }
}
