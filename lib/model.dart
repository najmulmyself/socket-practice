class MyData {
  final String name;
  final int age;

  MyData({
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'age': age,
    };
  }

  factory MyData.fromMap(Map<String, dynamic> map) {
    return MyData(
      name: map['name'],
      age: map['age'],
    );
  }
}
