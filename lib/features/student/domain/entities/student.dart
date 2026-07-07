/// Pure Domain Entity representing a Student.
class Student {
  final String name;
  final String profileURL;
  final int id;
  final int age;
  final String gender;
  final String contactNumber;

  const Student({
    required this.name,
    required this.profileURL,
    required this.id,
    required this.age,
    required this.gender,
    required this.contactNumber,
  });
}
