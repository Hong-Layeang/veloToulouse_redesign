import '../../model/bike.dart';

class BikeDTO {
  final String id;
  final String name;
  final String imageUrl;

  BikeDTO({required this.id, required this.name, required this.imageUrl});

  factory BikeDTO.fromJson(Map<String, dynamic> json) {
    return BikeDTO(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'imageUrl': imageUrl,
  };

  Bike toModel() => Bike(id: id, name: name, imageUrl: imageUrl);
}
