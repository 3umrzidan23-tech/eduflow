import '../entities/schedule_event.dart';

abstract class ScheduleRepository {
  Future<List<ScheduleEvent>> getEventsForDate(DateTime date);
}

class ScheduleRepositoryImpl implements ScheduleRepository {
  @override
  Future<List<ScheduleEvent>> getEventsForDate(DateTime date) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    switch (date.weekday) {
      case DateTime.monday:
        return [
          ScheduleEvent(id: 'e1', title: 'Database Systems', type: 'Lecture', time: '09:00 AM - 11:00 AM', location: 'Hall A', instructor: 'Dr. Ali', date: date),
          ScheduleEvent(id: 'e2', title: 'Software Engineering', type: 'Lecture', time: '11:30 AM - 01:30 PM', location: 'Hall B', instructor: 'Dr. Tarek', date: date),
          ScheduleEvent(id: 'e3', title: 'Flutter Development', type: 'Lab', time: '02:00 PM - 04:00 PM', location: 'Lab 3', instructor: 'Eng. Ahmed', date: date),
        ];
      case DateTime.tuesday:
        return [
          ScheduleEvent(id: 'e4', title: 'Web Technology', type: 'Lecture', time: '09:00 AM - 11:00 AM', location: 'Hall C', instructor: 'Dr. Sara', date: date),
          ScheduleEvent(id: 'e5', title: 'Computer Networks', type: 'Lecture', time: '11:30 AM - 01:30 PM', location: 'Hall A', instructor: 'Dr. Khaled', date: date),
          ScheduleEvent(id: 'e6', title: 'Operating Systems', type: 'Lab', time: '02:00 PM - 04:00 PM', location: 'Lab 1', instructor: 'Eng. Omar', date: date),
        ];
      case DateTime.wednesday:
        return [
          ScheduleEvent(id: 'e7', title: 'Data Structures & Algorithms', type: 'Lecture', time: '09:00 AM - 11:00 AM', location: 'Hall B', instructor: 'Dr. Youssef', date: date),
          ScheduleEvent(id: 'e8', title: 'Database Systems', type: 'Lab', time: '11:30 AM - 01:30 PM', location: 'Lab 2', instructor: 'Eng. Mona', date: date),
          ScheduleEvent(id: 'e9', title: 'Software Engineering', type: 'Lab', time: '02:00 PM - 04:00 PM', location: 'Lab 4', instructor: 'Eng. Hassan', date: date),
        ];
      case DateTime.thursday:
        return [
          ScheduleEvent(id: 'e10', title: 'Web Technology', type: 'Lab', time: '09:00 AM - 11:00 AM', location: 'Lab 3', instructor: 'Eng. Nada', date: date),
          ScheduleEvent(id: 'e11', title: 'Operating Systems', type: 'Lecture', time: '11:30 AM - 01:30 PM', location: 'Hall C', instructor: 'Dr. Ramy', date: date),
          ScheduleEvent(id: 'e12', title: 'Flutter Development', type: 'Lecture', time: '02:00 PM - 04:00 PM', location: 'Hall A', instructor: 'Dr. Samy', date: date),
        ];
      case DateTime.friday:
        return [
          ScheduleEvent(id: 'e13', title: 'Computer Networks', type: 'Lab', time: '09:00 AM - 11:00 AM', location: 'Lab 1', instructor: 'Eng. Karim', date: date),
          ScheduleEvent(id: 'e14', title: 'Data Structures & Algorithms', type: 'Lab', time: '11:30 AM - 01:30 PM', location: 'Lab 2', instructor: 'Eng. Yasmine', date: date),
        ];
      case DateTime.saturday:
      case DateTime.sunday:
      default:
        return [];
    }
  }
}
