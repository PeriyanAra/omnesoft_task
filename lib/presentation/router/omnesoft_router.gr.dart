// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:omnesoft_task/presentation/home/home_screen.dart' as _i1;
import 'package:omnesoft_task/presentation/settings/settings_screen.dart'
    as _i2;
import 'package:omnesoft_task/presentation/vendor_details/vendor_details_screen.dart'
    as _i3;
import 'package:omnesoft_task/presentation/view_models/vendor_view_model.dart'
    as _i6;

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i4.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i4.PageRouteInfo>? children})
    : super(HomeScreenRoute.name, initialChildren: children);

  static const String name = 'HomeScreenRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i1.HomeScreen();
    },
  );
}

/// generated route for
/// [_i2.SettingsScreen]
class SettingsScreenRoute extends _i4.PageRouteInfo<void> {
  const SettingsScreenRoute({List<_i4.PageRouteInfo>? children})
    : super(SettingsScreenRoute.name, initialChildren: children);

  static const String name = 'SettingsScreenRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i2.SettingsScreen();
    },
  );
}

/// generated route for
/// [_i3.VendorDetailsScreen]
class VendorDetailsScreenRoute
    extends _i4.PageRouteInfo<VendorDetailsScreenRouteArgs> {
  VendorDetailsScreenRoute({
    _i5.Key? key,
    required _i6.VendorViewModel vendor,
    required String tag,
    List<_i4.PageRouteInfo>? children,
  }) : super(
         VendorDetailsScreenRoute.name,
         args: VendorDetailsScreenRouteArgs(key: key, vendor: vendor, tag: tag),
         initialChildren: children,
       );

  static const String name = 'VendorDetailsScreenRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VendorDetailsScreenRouteArgs>();
      return _i3.VendorDetailsScreen(
        key: args.key,
        vendor: args.vendor,
        tag: args.tag,
      );
    },
  );
}

class VendorDetailsScreenRouteArgs {
  const VendorDetailsScreenRouteArgs({
    this.key,
    required this.vendor,
    required this.tag,
  });

  final _i5.Key? key;

  final _i6.VendorViewModel vendor;

  final String tag;

  @override
  String toString() {
    return 'VendorDetailsScreenRouteArgs{key: $key, vendor: $vendor, tag: $tag}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VendorDetailsScreenRouteArgs) return false;
    return key == other.key && vendor == other.vendor && tag == other.tag;
  }

  @override
  int get hashCode => key.hashCode ^ vendor.hashCode ^ tag.hashCode;
}
