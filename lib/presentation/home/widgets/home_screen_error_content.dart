import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations.dart';
import 'package:omnesoft_task/presentation/home/cubit/home_cubit.dart';
import 'package:provider/provider.dart';

class HomeScreenErrorContent extends StatelessWidget {
  const HomeScreenErrorContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTheme = OmnesoftColorTheme.of(context);

    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().loadVendors(),
      color: colorTheme.iconPrimary,
      backgroundColor: colorTheme.backgroundSecondary,
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          SizedBox(height: 24),
          Center(child: Text('An error occured! Please try again.')),
        ],
      ),
    );
  }
}
