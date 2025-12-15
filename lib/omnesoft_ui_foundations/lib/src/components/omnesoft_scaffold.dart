import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations/lib/src/themes.dart';

class OmnesoftScaffold extends StatelessWidget {
  const OmnesoftScaffold({
    this.backgroundColor,
    this.backgroundGradient,
    this.padding,
    this.appBar,
    this.body,
    this.resizeToAvoidBottomInset,
    this.backgroundImagePath,
    super.key,
  });

  final Color? backgroundColor;
  final Gradient? backgroundGradient;
  final Widget? body;
  final PreferredSizeWidget? appBar;
  final EdgeInsets? padding;
  final bool? resizeToAvoidBottomInset;
  final String? backgroundImagePath;

  @override
  Widget build(BuildContext context) {
    final colorTheme = OmnesoftColorTheme.of(context);

    return Scaffold(
      backgroundColor: backgroundColor ?? colorTheme.backgroundPrimary,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      body: Container(
        padding: padding,
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: body,
      ),
    );
  }
}
