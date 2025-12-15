import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations/lib/Omnesoft_ui_foundations.dart';
import 'package:omnesoft_task/presentation/common.dart';
import 'package:omnesoft_task/presentation/vendor_details/widgets/value_container.dart';
import 'package:omnesoft_task/presentation/view_models/vendor_view_model.dart';

@RoutePage()
class VendorDetailsScreen extends StatelessWidget {
  const VendorDetailsScreen({
    super.key,
    required this.vendor,
    required this.tag,
  });
  final VendorViewModel vendor;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final textTheme = OmnesoftTextTheme.of(context);
    final colorTheme = OmnesoftColorTheme.of(context);

    return OmnesoftScaffold(
      appBar: OmnesoftAppBar(
        title: vendor.name,
        hasBackgroundColor: false,
        systemOverlayStyle:
            context.watch<ThemeCubit>().state.mode == ThemeMode.dark
                ? SystemUiOverlayStyle.light
                : SystemUiOverlayStyle.dark,
        leading: IconButton(
          onPressed: () => context.router.pop(),
          icon: Icon(Icons.arrow_back_ios, color: colorTheme.primary),
        ),
        actions: [
          Icon(Icons.star, color: colorTheme.remind),
          Text(vendor.rating.toStringAsFixed(1), style: textTheme.body1Medium),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10,
          children: [
            Hero(
              tag: tag,
              child: OmnesoftCachedNetworkImage(
                imageUrl: vendor.image,
                heigtht: 200,
                width: MediaQuery.of(context).size.width,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Category',
                    style: textTheme.headline5Regular.copyWith(
                      color: colorTheme.textPrimary,
                    ),
                  ),
                  ValueContainer(text: vendor.category),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Location',
                    style: textTheme.headline5Regular.copyWith(
                      color: colorTheme.textPrimary,
                    ),
                  ),
                  ValueContainer(text: vendor.location),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
