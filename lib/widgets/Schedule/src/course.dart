class Course {
  final String subject;
  final String title;
  final List<String> days;
  final int startTime;
  final int endTime;

  const Course(
    {this.subject,
      this.title,
      this.days,
      this.startTime,
      this.endTime});
}

final courses = [
  new Course(
    subject: "COSI",
    title: "COSI164",
    days: ["MON", "WED", "THU",],
    startTime: 9,
    endTime: 11,
  ),
  new Course(
    subject: "COSI",
    title: "COSI165",
    days: ["MON", "WED", "THU",],
    startTime: 8,
    endTime: 10,
  ),
  new Course(
    subject: "COSI",
    title: "COSI166",
    days: ["MON", "WED", "THU",],
    startTime: 10,
    endTime: 12,
  ),
  new Course(
    subject: "COSI",
    title: "COSI164",
    days: ["MON", "WED", "THU",],
    startTime: 9,
    endTime: 11,
  ),
  new Course(
    subject: "COSI",
    title: "COSI165",
    days: ["MON", "WED", "THU",],
    startTime: 8,
    endTime: 10,
  ),
  new Course(
    subject: "COSI",
    title: "COSI166",
    days: ["MON", "WED", "THU",],
    startTime: 10,
    endTime: 12,
  ),
  new Course(
    subject: "COSI",
    title: "COSI164",
    days: ["MON", "WED", "THU",],
    startTime: 9,
    endTime: 11,
  ),
  new Course(
    subject: "COSI",
    title: "COSI165",
    days: ["MON", "WED", "THU",],
    startTime: 8,
    endTime: 10,
  ),
  new Course(
    subject: "COSI",
    title: "COSI166",
    days: ["MON", "WED", "THU",],
    startTime: 10,
    endTime: 12,
  ),
];