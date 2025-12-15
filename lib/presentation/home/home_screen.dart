import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations.dart';
import 'package:omnesoft_task/presentation/common.dart';
import 'package:omnesoft_task/presentation/home/cubit/home_cubit.dart';
import 'package:omnesoft_task/presentation/home/widgets/home_screen_error_content.dart';
import 'package:omnesoft_task/presentation/home/widgets/home_screen_loaded_content.dart';
import 'package:omnesoft_task/presentation/home/widgets/home_screen_search_bar.dart';
import 'package:omnesoft_task/presentation/router/omnesoft_router.gr.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              context.read<BlocFactory>().get<HomeCubit>()..loadVendors(),
      child: const _HomeScreenContentBuilder(),
    );
  }
}

class _HomeScreenContentBuilder extends StatelessWidget {
  const _HomeScreenContentBuilder();

  @override
  Widget build(BuildContext context) {
    final colorTheme = OmnesoftColorTheme.of(context);

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: OmnesoftScaffold(
        backgroundColor: colorTheme.backgroundPrimary,
        appBar: OmnesoftAppBar(
          title: 'Vendors',
          hasBackgroundColor: false,
          systemOverlayStyle:
              context.watch<ThemeCubit>().state.mode == ThemeMode.dark
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
          actions: [
            IconButton(
              onPressed: () {
                context.router.push(const SettingsScreenRoute());
              },
              icon: Icon(Icons.settings, color: colorTheme.primary),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const HomeScreenSearchBar(),
              const SizedBox(height: 16),
              Expanded(
                child: BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoaded) {
                      return HomeScreenLoadedContent(
                        vendors: state.vendors,
                        enablePagination: !state.isSearching,
                      );
                    } else if (state is HomeError) {
                      return const HomeScreenErrorContent();
                    }

                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
