import 'package:equatable/equatable.dart';
import '../../domain/entities/assignment.dart';

abstract class AssignmentsState extends Equatable {
  const AssignmentsState();

  @override
  List<Object?> get props => [];
}

class AssignmentsInitial extends AssignmentsState {}

class AssignmentsLoading extends AssignmentsState {}

class AssignmentsLoaded extends AssignmentsState {
  final List<Assignment> assignments;

  const AssignmentsLoaded({required this.assignments});

  @override
  List<Object?> get props => [assignments];
}

class AssignmentsFailure extends AssignmentsState {
  final String message;

  const AssignmentsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
