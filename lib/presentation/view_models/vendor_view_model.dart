import 'package:omnesoft_task/domain.dart';

class VendorViewModel {
  VendorViewModel({
    required this.vendorId,
    required this.name,
    required this.location,
    required this.rating,
    required this.category,
    required this.image,
  });

  factory VendorViewModel.fromEntity(VendorEntity entity) {
    return VendorViewModel(
      vendorId: entity.vendorId,
      name: entity.name,
      location: entity.location,
      rating: entity.rating,
      category: entity.category,
      image: entity.image,
    );
  }

  final int vendorId;
  final String name;
  final String location;
  final double rating;
  final String category;
  final String image;
}
