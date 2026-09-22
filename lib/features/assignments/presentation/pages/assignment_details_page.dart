import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../cubit/assignment_details_cubit.dart';
import '../cubit/assignment_details_state.dart';

class AssignmentDetailsPage extends StatelessWidget {
  final String assignmentId;

  const AssignmentDetailsPage({super.key, required this.assignmentId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AssignmentDetailsCubit()..loadAssignmentDetails(assignmentId),
      child: const AssignmentDetailsView(),
    );
  }
}

class AssignmentDetailsView extends StatelessWidget {
  const AssignmentDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E293B)),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Assignment Details',
          style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BlocBuilder<AssignmentDetailsCubit, AssignmentDetailsState>(
          builder: (context, state) {
            if (state is AssignmentDetailsLoading || state is AssignmentDetailsInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AssignmentDetailsFailure) {
              return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
            } else if (state is AssignmentDetailsLoaded) {
              final assignment = state.assignment;
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          assignment.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          assignment.courseName,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Due Date',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  assignment.dueDate,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: _getStatusColor(assignment.status).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Text(
                                assignment.status,
                                style: TextStyle(
                                  color: _getStatusColor(assignment.status),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        if (assignment.score != null) ...[
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.star, color: Colors.green),
                                const SizedBox(width: 12),
                                Text(
                                  'Score: ${assignment.score}/100',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 32),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          assignment.description,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[700],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 100), // padding for bottom button
                      ],
                    ),
                  ),
                  if (assignment.status == 'Pending')
                    Positioned(
                      left: 24,
                      right: 24,
                      bottom: 24,
                      child: ElevatedButton(
                        onPressed: () {
                          // Submit Logic
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Assignment Submitted Successfully!')),
                          );
                          context.pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1E293B),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Submit Assignment', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    if (status == 'Submitted') return Colors.blue;
    if (status == 'Graded') return Colors.green;
    return Colors.orange;
  }
}
