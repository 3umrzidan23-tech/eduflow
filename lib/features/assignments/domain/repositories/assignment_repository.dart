import '../entities/assignment.dart';

abstract class AssignmentRepository {
  Future<List<Assignment>> getAssignments();
  Future<Assignment> getAssignmentDetails(String id);
}

class AssignmentRepositoryImpl implements AssignmentRepository {
  @override
  Future<List<Assignment>> getAssignments() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Assignment(
        id: 'a1',
        title: 'SQL Queries Practice',
        courseName: 'Database Systems',
        dueDate: 'Oct 25, 11:59 PM',
        status: 'Pending',
        description: 'Write SQL queries to retrieve data based on the provided schema.',
      ),
      Assignment(
        id: 'a2',
        title: 'Build a UI Layout',
        courseName: 'Flutter Development',
        dueDate: 'Oct 20, 11:59 PM',
        status: 'Submitted',
        description: 'Create a responsive UI layout matching the provided Figma design.',
      ),
      Assignment(
        id: 'a3',
        title: 'HTML & CSS Basics',
        courseName: 'Web Technology',
        dueDate: 'Oct 15, 11:59 PM',
        status: 'Graded',
        description: 'Build a static personal portfolio page.',
        score: 95,
      ),
      Assignment(
        id: 'a4',
        title: 'Network Packet Analysis',
        courseName: 'Computer Networks',
        dueDate: 'Nov 05, 11:59 PM',
        status: 'Pending',
        description: 'Use Wireshark to capture and analyze TCP/IP packets.',
      ),
      Assignment(
        id: 'a5',
        title: 'Process Scheduling Simulation',
        courseName: 'Operating Systems',
        dueDate: 'Nov 10, 11:59 PM',
        status: 'Pending',
        description: 'Implement a simulation of Round Robin scheduling in C/C++.',
      ),
      Assignment(
        id: 'a6',
        title: 'Binary Search Tree Implementation',
        courseName: 'Data Structures & Algorithms',
        dueDate: 'Nov 12, 11:59 PM',
        status: 'Pending',
        description: 'Write code to implement and traverse a BST.',
      ),
    ];
  }

  @override
  Future<Assignment> getAssignmentDetails(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final assignments = await getAssignments();
    return assignments.firstWhere((a) => a.id == id);
  }
}
