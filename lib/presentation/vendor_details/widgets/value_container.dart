import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations.dart';

class ValueContainer extends StatelessWidget {
  const ValueContainer({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colorTheme = OmnesoftColorTheme.of(context);
    final textTheme = OmnesoftTextTheme.of(context);

    return Container(
      width: 150,
      height: 35,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: colorTheme.textSecondary),
        borderRadius: BorderRadius.circular(8),
        color: colorTheme.backgroundSecondary,
      ),
      child: Text(
        text,
        maxLines: 1,
        style: textTheme.body3Medium,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
