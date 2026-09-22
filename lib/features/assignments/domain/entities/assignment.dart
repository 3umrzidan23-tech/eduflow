class Assignment {
  final String id;
  final String title;
  final String courseName;
  final String dueDate;
  final String status; // 'Pending', 'Submitted', 'Graded'
  final String description;
  final int? score;

  Assignment({
    required this.id,
    required this.title,
    required this.courseName,
    required this.dueDate,
    required this.status,
    required this.description,
    this.score,
  });
}
