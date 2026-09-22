import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/schedule_repository.dart';
import 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ScheduleRepository _repository;
  DateTime _selectedDate = DateTime.now();

  ScheduleCubit({ScheduleRepository? repository})
      : _repository = repository ?? ScheduleRepositoryImpl(),
        super(ScheduleInitial());

  Future<void> loadEventsForDate(DateTime date) async {
    _selectedDate = date;
    emit(ScheduleLoading());
    try {
      final events = await _repository.getEventsForDate(date);
      emit(ScheduleLoaded(selectedDate: _selectedDate, events: events));
    } catch (e) {
      emit(ScheduleFailure(message: 'Failed to load schedule: ${e.toString()}'));
    }
  }

  void selectDate(DateTime date) {
    loadEventsForDate(date);
  }
}
