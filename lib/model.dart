class MyData {
  final int id;
  final String name;
  final int age;

  MyData({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  factory MyData.fromMap(Map<String, dynamic> map) {
    return MyData(
      id: map['id'],
      name: map['name'],
      age: map['age'],
    );
  }
}
