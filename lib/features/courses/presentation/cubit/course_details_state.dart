import 'package:equatable/equatable.dart';
import '../../domain/entities/course.dart';

abstract class CourseDetailsState extends Equatable {
  const CourseDetailsState();

  @override
  List<Object?> get props => [];
}

class CourseDetailsInitial extends CourseDetailsState {}

class CourseDetailsLoading extends CourseDetailsState {}

class CourseDetailsLoaded extends CourseDetailsState {
  final Course course;

  const CourseDetailsLoaded({required this.course});

  @override
  List<Object?> get props => [course];
}

class CourseDetailsFailure extends CourseDetailsState {
  final String message;

  const CourseDetailsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
