class ScheduleEvent {
  final String id;
  final String title;
  final String type; // e.g., 'Lecture', 'Lab', 'Exam'
  final String time; // e.g., '09:00 AM - 11:00 AM'
  final String location;
  final String instructor;
  final DateTime date;

  ScheduleEvent({
    required this.id,
    required this.title,
    required this.type,
    required this.time,
    required this.location,
    required this.instructor,
    required this.date,
  });
}
