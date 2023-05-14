class Student {
  final String? id;
  final String? name;
  bool? isPresent = false;

  Student(
    this.id,
    this.name,
  );

  set setIsPresent(bool x) => isPresent = x;
}
