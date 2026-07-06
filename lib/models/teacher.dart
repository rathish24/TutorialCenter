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
      name: map['name'] ?? '',
      profileURL: map['profileURL'] ?? '',
      id: map['id'] ?? 0,
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      contactNumber: map['contactNumber'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profileURL': profileURL,
      'id': id,
      'age': age,
      'gender': gender,
      'contactNumber': contactNumber,
    };
  }
}

