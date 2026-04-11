import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/menu_category_chip.dart';
import 'package:orda_merchant/features/menu_category/presentation/bloc/menu_category_list/menu_category_list_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuCategoryHorizontalList extends StatelessWidget {
  const MenuCategoryHorizontalList({
    required this.controller,
    super.key,
  });

  final ItemScrollController controller;

  @override
  Widget build(BuildContext context) {
    final categories = context
        .watch<MenuCategoryListBloc>()
        .state
        .categories;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 16,
        children: [
          const SizedBox(),
          ...categories.map((category) {
            final index = categories.indexWhere(
              (cat) => cat.id == category.id,
            );
            return MenuCategoryChip(
              category: category,
              onTap: () async {
                await controller.scrollTo(
                  index: index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            );
          }),
          const SizedBox(),
        ],
      ),
    );
  }
}
