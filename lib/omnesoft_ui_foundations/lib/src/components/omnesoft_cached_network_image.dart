import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations.dart';

class OmnesoftCachedNetworkImage extends StatelessWidget {
  const OmnesoftCachedNetworkImage({
    required this.imageUrl,
    this.heigtht,
    this.width,
    this.borderRadius,
    super.key,
  });

  final String imageUrl;
  final double? heigtht;
  final double? width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final colorTheme = OmnesoftColorTheme.of(context);

    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: heigtht,
      fit: BoxFit.cover,
      imageBuilder:
          (context, imageProvider) => Container(
            width: width,
            height: heigtht,
            decoration: BoxDecoration(
              borderRadius: borderRadius,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            ),
          ),
      placeholder:
          (context, url) => Container(
            width: width,
            height: heigtht,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colorTheme.backgroundSecondary,
                  colorTheme.backgroundPrimary,
                  colorTheme.backgroundSecondary,
                ],
              ),
              borderRadius: borderRadius,
            ),
          ),
      errorWidget:
          (context, url, error) => Container(
            width: width,
            height: heigtht,
            decoration: BoxDecoration(
              color: colorTheme.backgroundSecondary,
              borderRadius: borderRadius,
            ),
            child: Icon(
              Icons.business,
              size: 32,
              color: colorTheme.iconPrimary,
            ),
          ),
    );
  }
}
