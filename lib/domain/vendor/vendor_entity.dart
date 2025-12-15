class VendorEntity {
  VendorEntity({
    required this.vendorId,
    required this.name,
    required this.location,
    required this.rating,
    required this.category,
    required this.image,
  });

  final int vendorId;
  final String name;
  final String location;
  final double rating;
  final String category;
  final String image;
}
