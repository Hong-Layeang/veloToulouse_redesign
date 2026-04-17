class Bike {
  final String name;
  final String id;
  final String imageUrl;
 
  const Bike({
    required this.name,
    required this.id,
    required this.imageUrl,
  });

  @override
  String toString() {
    return 'Bike(id: $id, name: $name, imageUrl: $imageUrl)';
  }
}