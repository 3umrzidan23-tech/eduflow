import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/assignment_repository.dart';
import 'assignment_details_state.dart';

class AssignmentDetailsCubit extends Cubit<AssignmentDetailsState> {
  final AssignmentRepository _repository;

  AssignmentDetailsCubit({AssignmentRepository? repository})
      : _repository = repository ?? AssignmentRepositoryImpl(),
        super(AssignmentDetailsInitial());

  Future<void> loadAssignmentDetails(String id) async {
    emit(AssignmentDetailsLoading());
    try {
      final assignment = await _repository.getAssignmentDetails(id);
      emit(AssignmentDetailsLoaded(assignment: assignment));
    } catch (e) {
      emit(AssignmentDetailsFailure(message: 'Failed to load assignment details: ${e.toString()}'));
    }
  }
}
