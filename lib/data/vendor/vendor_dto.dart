import 'package:omnesoft_task/domain.dart';

class VendorDto {
  VendorDto({
    required this.vendorId,
    required this.name,
    required this.location,
    required this.rating,
    required this.category, 
    required this.image,
  });

  factory VendorDto.fromJson(Map<String, dynamic> json) {
    return VendorDto(
      vendorId: json['vendorId'] as int,
      name: json['name'] as String,
      location: json['location'] as String,
      rating: (json['rating'] as num).toDouble(),
      category: json['category'] as String, 
      image: json['image'] as String,
    );
  }

  final int vendorId;
  final String name;
  final String location;
  final double rating;
  final String category;
  final String image;

  Map<String, dynamic> toJson() {
    return {
      'vendorId': vendorId,
      'name': name,
      'location': location,
      'rating': rating,
      'category': category,
      'image': image,
    };
  }

  VendorEntity toEntity() {
    return VendorEntity(
      vendorId: vendorId,
      name: name,
      location: location,
      rating: rating,
      category: category,
      image: image,
    );
  }
}
