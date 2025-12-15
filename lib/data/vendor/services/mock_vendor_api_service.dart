import 'dart:async';
import 'dart:math';
import 'package:faker/faker.dart';

class MockVendorApiService {
  final Faker _faker = Faker();
  final Random _random = Random();

  Future<List<Map<String, dynamic>>> fetchVendors({
    int limit = 10,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));

    return List.generate(limit, (index) {
      return {
        'vendorId': index + 1,
        'name': _faker.company.name(),
        'location': _faker.address.city(),
        'rating': _generateRating(),
        'category': _generateCategory(),
        'image': _generateImageUrl(),
      };
    });
  }

  double _generateRating() {
    return double.parse((3.5 + _random.nextDouble() * 1.5).toStringAsFixed(1));
  }

  String _generateCategory() {
    const categories = [
      'Electronics',
      'Fashion',
      'Food',
      'Health',
      'Home & Living',
      'Automotive',
      'Sports',
    ];

    return categories[_random.nextInt(categories.length)];
  }

  String _generateImageUrl() {
    return 'https://picsum.photos/seed/${_random.nextInt(200)}/500/500';
  }
}
