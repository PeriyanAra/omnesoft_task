import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations.dart';

class VendorCardImage extends StatelessWidget {
  const VendorCardImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return OmnesoftCachedNetworkImage(
      imageUrl: imageUrl,
      heigtht: 60,
      width: 60,
      borderRadius: BorderRadius.circular(8),
    );
  }
}
