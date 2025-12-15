part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeLoading extends HomeState {
  HomeLoading();
}

final class HomeLoaded extends HomeState {
  HomeLoaded({required this.vendors, this.isSearching = false});

  final List<VendorViewModel> vendors;
  final bool isSearching;
}

final class HomeError extends HomeState {
  HomeError({required this.message});

  final String message;
}
