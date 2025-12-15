import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations.dart';
import 'package:omnesoft_task/presentation/home/cubit/home_cubit.dart';
import 'package:omnesoft_task/presentation/home/widgets/vendor_card.dart';
import 'package:omnesoft_task/presentation/router/omnesoft_router.gr.dart';
import 'package:omnesoft_task/presentation/view_models.dart';
import 'package:provider/provider.dart';

class HomeScreenLoadedContent extends StatefulWidget {
  const HomeScreenLoadedContent({
    super.key,
    required this.vendors,
    this.enablePagination = true,
  });

  final List<VendorViewModel> vendors;
  final bool enablePagination;

  @override
  State<HomeScreenLoadedContent> createState() =>
      _HomeScreenLoadedContentState();
}

class _HomeScreenLoadedContentState extends State<HomeScreenLoadedContent> {
  late ScrollController _scrollController;
  Timer? _paginationDebounce;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    FocusManager.instance.primaryFocus?.unfocus();

    if (!widget.enablePagination) return;
    if (!_scrollController.hasClients) return;

    final position = _scrollController.position;
    if (position.userScrollDirection != ScrollDirection.reverse) return;

    if (position.maxScrollExtent <= 0) return;

    if (position.extentAfter > 200) return;

    _paginationDebounce?.cancel();
    _paginationDebounce = Timer(const Duration(milliseconds: 250), () {
      if (!mounted) return;
      context.read<HomeCubit>().loadAdditionalVendors();
    });
  }

  @override
  void dispose() {
    _paginationDebounce?.cancel();
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = OmnesoftColorTheme.of(context);

    return RefreshIndicator(
      onRefresh: () => context.read<HomeCubit>().loadVendors(),
      color: colorTheme.iconPrimary,
      backgroundColor: colorTheme.backgroundSecondary,
      child:
          widget.vendors.isEmpty
              ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 24),
                  Center(child: Text('No vendors found')),
                ],
              )
              : ListView.separated(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                itemCount:
                    (widget.enablePagination)
                        ? widget.vendors.length + 1
                        : widget.vendors.length,
                itemBuilder: (context, index) {
                  if (index == widget.vendors.length) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return VendorCard(
                    tag: 'hero-$index',
                    vendor: widget.vendors[index],
                    onTap: () => _onVendorCardTap(index),
                  );
                },
              ),
    );
  }

  void _onVendorCardTap(int index) {
    FocusManager.instance.primaryFocus?.unfocus();
    context.router.push(
      VendorDetailsScreenRoute(
        vendor: widget.vendors[index],
        tag: 'hero-$index',
      ),
    );
  }
}
