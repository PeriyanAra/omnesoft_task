import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations/lib/src/themes.dart';

class OmnesoftAppBar extends StatelessWidget implements PreferredSizeWidget {
  const OmnesoftAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.systemOverlayStyle,
    this.hasBackgroundColor = true,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool hasBackgroundColor;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final textTheme = OmnesoftTextTheme.of(context);
    final appBarTheme = OmnesoftAppBarTheme.of(context);

    return AppBar(
      backgroundColor:
          hasBackgroundColor ? appBarTheme.backgroundColor : Colors.transparent,
      title: Text(title ?? '', style: textTheme.body1Regular),
      centerTitle: appBarTheme.centerTitle,
      actions: actions,
      surfaceTintColor: Colors.transparent,
      actionsIconTheme: IconThemeData(
        color: appBarTheme.actionsIconColor,
        size: appBarTheme.actionsIconSize,
      ),
      actionsPadding: appBarTheme.actionsPadding,
      systemOverlayStyle: systemOverlayStyle,
      leading: leading,
    );
  }
}
