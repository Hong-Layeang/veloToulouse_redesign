class Bike {
  final String name;
  final String id;
 
  const Bike({
    required this.name,
    required this.id,
  });

  @override
  String toString() {
    return 'Bike(id: $id, name: $name)';
  }
}
