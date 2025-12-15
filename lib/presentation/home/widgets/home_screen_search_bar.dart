import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations.dart';
import 'package:omnesoft_task/presentation/home/cubit/home_cubit.dart';

class HomeScreenSearchBar extends StatefulWidget {
  const HomeScreenSearchBar({super.key});

  @override
  State<HomeScreenSearchBar> createState() => _HomeScreenSearchBarState();
}

class _HomeScreenSearchBarState extends State<HomeScreenSearchBar> {
  late TextEditingController _controller;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
    _controller.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      final query = _controller.text;

      context.read<HomeCubit>().searchVendors(query);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller
      ..removeListener(_onSearchChanged)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = OmnesoftColorTheme.of(context);

    return OmnesoftTextField(
      controller: _controller,
      hintText: 'Search',
      suffixIcon: ValueListenableBuilder(
        valueListenable: _controller,
        builder: (context, value, child) {
          return value.text.isNotEmpty
              ? IconButton(
                icon: Icon(Icons.close_rounded, color: colorTheme.iconPrimary),
                onPressed: _onClearPresed,
              )
              : const SizedBox.shrink();
        },
      ),
      preffixIcon: Icon(Icons.search_rounded, color: colorTheme.iconPrimary),
    );
  }

  void _onClearPresed() {
    _controller.clear();

    FocusScope.of(context).unfocus();
    context.read<HomeCubit>().cancelSearching();
  }
}
