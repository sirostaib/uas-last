class Course {
  late String email;
  late String cName;
  late String cCode;

  Course.copy({
    required this.email,
    required this.cName,
    required this.cCode,
  });
  Course();
  // static Course fromMap(Map<String, dynamic> map) {
  //   return Course.copy(
  //       email: map['email'],
  //       cName: map['courseName'],
  //       cCode: map['courseCode']);
  // }
}
