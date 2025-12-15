import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations.dart';
import 'package:omnesoft_task/presentation/home/widgets/vendor_card_image.dart';
import 'package:omnesoft_task/presentation/view_models/vendor_view_model.dart';

class VendorCard extends StatelessWidget {
  const VendorCard({
    super.key,
    required this.vendor,
    required this.onTap,
    required this.tag,
  });
  final VendorViewModel vendor;
  final VoidCallback onTap;
  final String tag;

  @override
  Widget build(BuildContext context) {
    final colorTheme = OmnesoftColorTheme.of(context);
    final textTheme = OmnesoftTextTheme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(20),
      color: colorTheme.backgroundSecondary,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        highlightColor: colorTheme.primary.withAlpha(20),
        splashColor: colorTheme.primary.withAlpha(20),
        hoverColor: colorTheme.primary.withAlpha(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Hero(tag: tag, child: VendorCardImage(imageUrl: vendor.image)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vendor.name,
                      style: textTheme.body1Medium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(vendor.category, style: textTheme.body2Regular),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 16,
                          color: colorTheme.remind,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          vendor.rating.toStringAsFixed(1),
                          style: textTheme.body2Regular,
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: colorTheme.iconPrimary),
            ],
          ),
        ),
      ),
    );
  }
}
