import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/assignment_repository.dart';
import 'assignments_state.dart';

class AssignmentsCubit extends Cubit<AssignmentsState> {
  final AssignmentRepository _repository;

  AssignmentsCubit({AssignmentRepository? repository})
      : _repository = repository ?? AssignmentRepositoryImpl(),
        super(AssignmentsInitial());

  Future<void> loadAssignments() async {
    emit(AssignmentsLoading());
    try {
      final assignments = await _repository.getAssignments();
      emit(AssignmentsLoaded(assignments: assignments));
    } catch (e) {
      emit(AssignmentsFailure(message: 'Failed to load assignments: ${e.toString()}'));
    }
  }
}
