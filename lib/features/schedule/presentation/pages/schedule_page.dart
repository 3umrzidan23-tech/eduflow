import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../cubit/schedule_cubit.dart';
import '../cubit/schedule_state.dart';
import '../../domain/entities/schedule_event.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScheduleCubit()..loadEventsForDate(DateTime.now()),
      child: const ScheduleView(),
    );
  }
}

class ScheduleView extends StatefulWidget {
  const ScheduleView({super.key});

  @override
  State<ScheduleView> createState() => _ScheduleViewState();
}

class _ScheduleViewState extends State<ScheduleView> {
  final List<DateTime> _weekDays = [];

  @override
  void initState() {
    super.initState();
    _generateWeekDays();
  }

  void _generateWeekDays() {
    final now = DateTime.now();
    for (int i = 0; i < 7; i++) {
      _weekDays.add(now.add(Duration(days: i)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Schedule',
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<ScheduleCubit, ScheduleState>(
        builder: (context, state) {
          DateTime selectedDate = DateTime.now();
          if (state is ScheduleLoaded) {
            selectedDate = state.selectedDate;
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDateSelector(context, selectedDate),
              const SizedBox(height: 16),
              Expanded(
                child: _buildScheduleContent(state),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, DateTime selectedDate) {
    return SizedBox(
      height: 90,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: _weekDays.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final date = _weekDays[index];
          final isSelected = date.year == selectedDate.year &&
              date.month == selectedDate.month &&
              date.day == selectedDate.day;

          return GestureDetector(
            onTap: () {
              context.read<ScheduleCubit>().selectDate(date);
            },
            child: Container(
              width: 60,
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? const Color(0xFF1E293B) : Colors.grey.shade300,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEE').format(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white70 : Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : const Color(0xFF1E293B),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildScheduleContent(ScheduleState state) {
    if (state is ScheduleLoading || state is ScheduleInitial) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is ScheduleFailure) {
      return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
    } else if (state is ScheduleLoaded) {
      final events = state.events;
      if (events.isEmpty) {
        return const Center(
          child: Text(
            'No classes for this day.',
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        );
      }
      return ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        itemCount: events.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final event = events[index];
          return _EventCard(event: event);
        },
      );
    }
    return const SizedBox();
  }
}

class _EventCard extends StatelessWidget {
  final ScheduleEvent event;

  const _EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.class_, color: Colors.blueAccent),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        event.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        event.type,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      event.time,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      event.location,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.blue.withValues(alpha: 0.2),
                      child: const Icon(Icons.person, size: 12, color: Colors.blueAccent),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      event.instructor,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
