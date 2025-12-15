import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';
import 'package:omnesoft_task/presentation/common.dart';
import 'package:omnesoft_task/presentation/router/omnesoft_router.dart';
import 'package:omnesoft_task/presentation/theme/omnesoft_theme.dart';

class OmnesoftApp extends StatefulWidget {
  const OmnesoftApp({super.key, required this.di});
  final DI di;

  @override
  State<OmnesoftApp> createState() => _OmnesoftAppState();
}

class _OmnesoftAppState extends State<OmnesoftApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return CommonDependenciesProvider(
      di: widget.di,
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            color: Colors.transparent,
            routerConfig: _appRouter.config(),
            theme: OmnesoftAppTheme.light(),
            darkTheme: OmnesoftAppTheme.dark(),
            themeMode: state.mode,
          );
        },
      ),
    );
  }
}
