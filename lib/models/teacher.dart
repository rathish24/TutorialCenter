class Teacher {
  String name;
  String profileURL;
  int id;
  int  age;
  String gender;
  String contactNumber;

  Teacher({
    required this.name,
    required this.profileURL,
    required this.id,
    required this.age,
    required this.gender,
    required this.contactNumber,
  });

  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      name: map['name'],
      profileURL: map['profileURL'],
      id: map['id'],
      age: map['age'],
      gender: map['gender'],
      contactNumber: map['contactNumber'],
    );
  }

}

