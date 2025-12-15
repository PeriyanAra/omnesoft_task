import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnesoft_task/domain/vendor.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';
import 'package:omnesoft_task/presentation/view_models.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required VendorRepository vendorRepository})
    : _vendorRepository = vendorRepository,
      super(HomeLoading());

  final VendorRepository _vendorRepository;
  bool _isLoadingAdditional = false;

  var _allVendors = <VendorViewModel>[];
  var _searchQuery = '';

  Future<void> loadVendors() async {
    if (_allVendors.isEmpty) {
      safeEmit(HomeLoading());
    }

    final newVendorsResponse = await _vendorRepository.fetchVendors();

    newVendorsResponse.when(
      success: (data) {
        final newVendors = data.map(VendorViewModel.fromEntity).toList();

        _allVendors = newVendors;
        _emitLoaded();
      },
      failure: (error) {
        safeEmit(HomeError(message: error.toString()));
      },
    );
  }

  Future<void> loadAdditionalVendors() async {
    if (_isLoadingAdditional || state is! HomeLoaded) return;

    _isLoadingAdditional = true;

    try {
      final newVendorsResponse = await _vendorRepository.fetchVendors();

      newVendorsResponse.when(
        success: (data) {
          final newVendors = data.map(VendorViewModel.fromEntity).toList();

          _allVendors = [..._allVendors, ...newVendors];
          _emitLoaded();
        },
        failure: (error) {
          safeEmit(HomeError(message: error.toString()));
        },
      );
    } finally {
      _isLoadingAdditional = false;
    }
  }

  void searchVendors(String searchQuery) {
    if (_searchQuery.isEmpty && searchQuery.isEmpty) return;

    final filteredVendors =
        _allVendors
            .where(
              (vendor) =>
                  vendor.name.toLowerCase().contains(searchQuery.toLowerCase()),
            )
            .toList();

    safeEmit(HomeLoaded(vendors: filteredVendors, isSearching: true));

    _searchQuery = searchQuery;
  }

  void cancelSearching() {
    safeEmit(HomeLoaded(vendors: _allVendors));

    _searchQuery = '';
  }

  void _emitLoaded() {
    if (_searchQuery.isNotEmpty) {
      safeEmit(
        HomeLoaded(
          vendors: _filterVendors(_allVendors, _searchQuery),
          isSearching: true,
        ),
      );
    } else {
      safeEmit(HomeLoaded(vendors: _allVendors));
    }
  }

  List<VendorViewModel> _filterVendors(
    List<VendorViewModel> vendors,
    String searchQuery,
  ) {
    return vendors
        .where(
          (vendor) =>
              vendor.name.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
  }
}
