import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations/lib/omnesoft_ui_foundations.dart';

class OmnesoftTextField extends StatefulWidget {
  const OmnesoftTextField({
    super.key,
    this.controller,
    this.hintText,
    this.errorMessage,
    this.suffixIcon,
    this.preffixIcon,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? errorMessage;
  final Widget? preffixIcon;
  final Widget? suffixIcon;

  @override
  State<OmnesoftTextField> createState() => _OmnesoftTextFieldState();
}

class _OmnesoftTextFieldState extends State<OmnesoftTextField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = OmnesoftTextFieldTheme.of(context);

    return TextField(
      controller: controller,
      style: theme.textStyle,
      cursorColor: theme.cursorColor,
      cursorHeight: theme.cursorHeight,
      cursorErrorColor: theme.cursorErrorColor,
      autocorrect: false,
      decoration: InputDecoration(
        prefixIcon: widget.preffixIcon,
        suffixIcon: widget.suffixIcon,
        contentPadding: theme.contentPadding,
        hintText: widget.hintText,
        border: theme.border,
        enabledBorder: theme.enabledBorder,
        focusedBorder: theme.focusedBorder,
        errorBorder: theme.errorBorder,
        hintStyle: theme.hintStyle,
        focusedErrorBorder: theme.focusedErrorBorder,
        filled: true,
        fillColor: theme.fillColor,
        error:
            widget.errorMessage != null
                ? Row(
                  children: [
                    if (theme.errorIcon != null) ...[
                      Icon(
                        theme.errorIcon,
                        color: theme.errorIconColor,
                        size: theme.errorIconSize,
                      ),
                      const SizedBox(width: 4),
                    ],
                    Text(widget.errorMessage!, style: theme.errorTextStyle),
                  ],
                )
                : null,
      ),
    );
  }
}
