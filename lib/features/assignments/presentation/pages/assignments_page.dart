import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/assignments_cubit.dart';
import '../cubit/assignments_state.dart';
import '../../domain/entities/assignment.dart';

class AssignmentsPage extends StatelessWidget {
  const AssignmentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignmentsCubit()..loadAssignments(),
      child: const AssignmentsView(),
    );
  }
}

class AssignmentsView extends StatelessWidget {
  const AssignmentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Assignments',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: BlocBuilder<AssignmentsCubit, AssignmentsState>(
        builder: (context, state) {
          if (state is AssignmentsLoading || state is AssignmentsInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AssignmentsFailure) {
            return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
          } else if (state is AssignmentsLoaded) {
            final assignments = state.assignments;
            return ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: assignments.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final assignment = assignments[index];
                return _AssignmentCard(assignment: assignment);
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

class _AssignmentCard extends StatelessWidget {
  final Assignment assignment;

  const _AssignmentCard({required this.assignment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/assignments/details/${assignment.id}');
      },
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    assignment.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ),
                _StatusChip(status: assignment.status),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              assignment.courseName,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  'Due: ${assignment.dueDate}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'Submitted':
        bgColor = Colors.blue.withValues(alpha: 0.1);
        textColor = Colors.blue;
        break;
      case 'Graded':
        bgColor = Colors.green.withValues(alpha: 0.1);
        textColor = Colors.green;
        break;
      case 'Pending':
      default:
        bgColor = Colors.orange.withValues(alpha: 0.1);
        textColor = Colors.orange;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
