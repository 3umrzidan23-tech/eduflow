import 'package:equatable/equatable.dart';
import '../../domain/entities/assignment.dart';

abstract class AssignmentDetailsState extends Equatable {
  const AssignmentDetailsState();

  @override
  List<Object?> get props => [];
}

class AssignmentDetailsInitial extends AssignmentDetailsState {}

class AssignmentDetailsLoading extends AssignmentDetailsState {}

class AssignmentDetailsLoaded extends AssignmentDetailsState {
  final Assignment assignment;

  const AssignmentDetailsLoaded({required this.assignment});

  @override
  List<Object?> get props => [assignment];
}

class AssignmentDetailsFailure extends AssignmentDetailsState {
  final String message;

  const AssignmentDetailsFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
