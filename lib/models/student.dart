class Student {
  String name;
  String profileURL;
  int id;
  int age;
  String gender;
  String contactNumber;

  Student({
    required this.name,
    required this.profileURL,
    required this.id,
    required this.age,
    required this.gender,
    required this.contactNumber,
  });

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      name: map['name'],
      profileURL: map['profileURL'],
      id: map['id'],
      age: map['age'],
      gender: map['gender'],
      contactNumber: map['contactNumber'],
    );
  }
}
