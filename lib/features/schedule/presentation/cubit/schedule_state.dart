import 'package:equatable/equatable.dart';
import '../../domain/entities/schedule_event.dart';

abstract class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final DateTime selectedDate;
  final List<ScheduleEvent> events;

  const ScheduleLoaded({required this.selectedDate, required this.events});

  @override
  List<Object?> get props => [selectedDate, events];
}

class ScheduleFailure extends ScheduleState {
  final String message;

  const ScheduleFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
