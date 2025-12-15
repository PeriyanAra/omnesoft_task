import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';
import 'package:omnesoft_task/presentation/common/cubits/theme_cubit/theme_cubit.dart';
import 'package:provider/provider.dart';

class CommonDependenciesProvider extends StatelessWidget {
  const CommonDependenciesProvider({
    super.key,
    required this.di,
    required this.child,
  });

  final DI di;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: BlocFactory(di: di)),
        BlocProvider.value(value: di<ThemeCubit>()..loadThemeMode()),
      ],
      child: child,
    );
  }
}
