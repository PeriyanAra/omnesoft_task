import 'package:flutter_test/flutter_test.dart';
import 'package:omnesoft_task/data/vendor/services/mock_vendor_api_service.dart';

void main() {
  late MockVendorApiService apiService;

  const expectedKeys = {
    'vendorId',
    'name',
    'location',
    'rating',
    'category',
    'image',
  };

  const categories = [
    'Electronics',
    'Fashion',
    'Food',
    'Health',
    'Home & Living',
    'Automotive',
    'Sports',
  ];

  setUp(() {
    apiService = MockVendorApiService();
  });

  group('MockVendorApiService', () {
    test(
      'fetchVendors returns default count with full payload shape',
      () async {
        final vendors = await apiService.fetchVendors();

        expect(vendors, hasLength(10));

        for (var index = 0; index < vendors.length; index++) {
          final vendor = vendors[index];

          expect(vendor.keys.toSet(), equals(expectedKeys));

          expect(vendor['vendorId'], index + 1);

          expect(vendor['name'], isA<String>());
          expect((vendor['name'] as String).isNotEmpty, isTrue);

          expect(vendor['location'], isA<String>());
          expect((vendor['location'] as String).isNotEmpty, isTrue);

          final rating = vendor['rating'] as double;
          expect(rating, inInclusiveRange(3.5, 5.0));
          expect(rating.toString(), matches(RegExp(r'^[3-5]\.[0-9]$')));
          expect(rating, equals(double.parse(rating.toStringAsFixed(1))));

          expect(categories, contains(vendor['category']));

          final imageUrl = vendor['image'] as String;
          expect(
            imageUrl,
            matches(RegExp(r'^https://picsum.photos/seed/\d+/500/500$')),
          );
        }
      },
    );

    test(
      'fetchVendors respects requested count and keeps sequential ids',
      () async {
        const requestedCount = 5;

        final vendors = await apiService.fetchVendors(limit: requestedCount);

        expect(vendors, hasLength(requestedCount));
        expect(
          vendors.map((vendor) => vendor.keys.toSet()),
          everyElement(equals(expectedKeys)),
        );
        expect(
          vendors.map((vendor) => vendor['vendorId']),
          orderedEquals(List.generate(requestedCount, (index) => index + 1)),
        );
        expect(
          vendors.map((vendor) => vendor['vendorId']),
          everyElement(isA<int>()),
        );
      },
    );

    test('fetchVendors returns empty list when count is zero', () async {
      final vendors = await apiService.fetchVendors(limit: 0);

      expect(vendors, isEmpty);
    });
  });
}
