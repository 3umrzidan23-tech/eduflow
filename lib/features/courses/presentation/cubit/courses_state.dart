import 'package:equatable/equatable.dart';
import '../../domain/entities/course.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object?> get props => [];
}

class CoursesInitial extends CoursesState {}

class CoursesLoading extends CoursesState {}

class CoursesLoaded extends CoursesState {
  final List<Course> courses;

  const CoursesLoaded({required this.courses});

  @override
  List<Object?> get props => [courses];
}

class CoursesFailure extends CoursesState {
  final String message;

  const CoursesFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
