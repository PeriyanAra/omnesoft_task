import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations/lib/Omnesoft_ui_foundations.dart';
import 'package:omnesoft_task/presentation/common.dart';
import 'package:omnesoft_task/presentation/theme.dart';

@RoutePage()
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = OmnesoftTextTheme.of(context);
    final colorTheme = OmnesoftColorTheme.of(context);

    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return OmnesoftScaffold(
          appBar: OmnesoftAppBar(
            title: 'Settings',
            hasBackgroundColor: false,
            systemOverlayStyle:
                state.mode == ThemeMode.dark
                    ? SystemUiOverlayStyle.light
                    : SystemUiOverlayStyle.dark,
            leading: IconButton(
              onPressed: () => context.router.pop(),
              icon: Icon(Icons.arrow_back_ios, color: colorTheme.primary),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Theme mode', style: textTheme.body1Medium),
                Container(
                  height: 40,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: colorTheme.primary,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _changeTheme(context),
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color:
                                state.mode == ThemeMode.light
                                    ? OmnesoftColors.orange30
                                    : null,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.light_mode),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _changeTheme(context),
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            color:
                                state.mode == ThemeMode.dark
                                    ? OmnesoftColors.orange30
                                    : null,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.dark_mode,
                            color:
                                state.mode == ThemeMode.light
                                    ? OmnesoftColors.white
                                    : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _changeTheme(BuildContext context) {
    context.read<ThemeCubit>().changeThemeMode();
  }
}
