import 'package:flutter/material.dart';
import 'package:orda_merchant/features/menu_category/domain/entities/menu_category.dart';
import 'package:orda_merchant/features/menu/presentation/widgets/menu_category_chip.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class MenuCategoryHorizontalList extends StatelessWidget {
  const MenuCategoryHorizontalList({
    required this.controller,
    required this.categories,
    super.key,
  });

  final ItemScrollController controller;
  final List<MenuCategory> categories;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(),
      child: SingleChildScrollView(
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
      ),
    );
  }
}
